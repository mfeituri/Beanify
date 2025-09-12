//
//  LoginVIewModel.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/23/25.
//

import Foundation
import SwiftUI
import CryptoKit
import SafariServices
import KeychainAccess



class LoginViewModel: ObservableObject{
    @Published var authURL: URL?
    @Published var isLoggedIn: Bool = false
    
    
    let keychain = Keychain(service: "com.mfeituri.beanify")
    
    //function for creating a code verifier
    func generateRandomString(length: Int) -> String{
        let possibleChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        var value: String = ""
        
        for _ in 0..<length {
            guard let unwrappedChar = possibleChars.randomElement() else {
                continue
            }
            value.append(unwrappedChar)
        }
        return value
    }
    
    //function for hashing the verifier to be pkce compliant
    func generateCodeChallenge(from verifier: String) -> String{
        
        let data = Data(verifier.utf8)
        let hashed = SHA256.hash(data: data)
        let hashData = Data(hashed)
        let base64 = hashData.base64EncodedString()
        
        let codeChallenge = base64
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
        
        return codeChallenge
        
    }
    
    //function for starting the oauth flow once login is clicked with spotify
    func startLogin(){
        let codeVerifier = generateRandomString(length: 64)
        UserDefaults.standard.setValue(codeVerifier, forKey: "code_verifier")
        let codeChallenge = generateCodeChallenge(from: codeVerifier)
        
        // url components help us form our url
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/authorize"
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Config.spotifyClientID),
            URLQueryItem(name: "response_type", value:"code"),
            URLQueryItem(name: "redirect_uri", value: "beanify://callback"),
            URLQueryItem(name: "scope", value:"user-top-read user-read-recently-played user-read-email user-read-private"),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "code_challenge", value: codeChallenge)
        ]
        if let url = components.url{
            self.authURL = url
            
        } else {
            print("invalid url")
        }
    }
    func handleRedirect( _ url: URL){
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let code = components?.queryItems?.first(where: {$0.name == "code"})?.value{
            
            
            exchangeCodeForToken(code: code)
        }
        else {
            print("no authorization code")
        }
    }
    
    
    
    func exchangeCodeForToken(code: String) {
        guard
            let verifier = UserDefaults.standard.string(forKey: "code_verifier"),
            let url = URL(string: "https://accounts.spotify.com/api/token")
        else {
            print("Missing verifier or invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyParams = [
            "client_id": "\(Config.spotifyClientID)",
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": "beanify://callback",
            "code_verifier": verifier
        ]
        
        let bodyString = bodyParams
            .map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")
        
        request.httpBody = bodyString.data(using: .utf8)
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during token exchange:", error)
                return
            }
            
            guard let data = data else {
                print("No data in response")
                return
            }
            
            // Decode the token response
            do {
                let tokenResponse = try JSONDecoder().decode(SpotifyTokenResponse.self, from: data)
                DispatchQueue.main.async {
                    do{
                        try self.keychain.set(tokenResponse.access_token, key: "access_token")
                    } catch {
                        print("failed to save access token to keychain", error)
                    }
                    self.fetchUserProfile()
                }
            } catch {
                print("Failed to decode token response:", error)
                print(String(data: data, encoding: .utf8) ?? "Raw response not printable")
            }
        }.resume()
    }
    
    func fetchUserProfile() {
        guard let token = try? keychain.get("access_token") else {
            print("no token in keychain")
            return
            
        }
        guard let url = URL(string: "https://api.spotify.com/v1/me") else {
            print("no user access token or invalid url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print("API error:", error)
                return
            }
            guard let data = data else {
                print("no data recieved")
                return
            }
            
            do {
                let profile = try JSONDecoder().decode(SpotifyUserProfile.self, from: data)
                DispatchQueue.main.async {
                    print("Logged in as:", profile.displayName ?? profile.id)
                    self.isLoggedIn = true
                    self.authURL = nil
                    
                }
            } catch {
                print("Failed to decode profile", error)
                print(String(data: data, encoding: .utf8) ?? "raw response not printable")
            }
        } .resume()
        
    }
    
    
}
