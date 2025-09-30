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

class LoginViewModel: ObservableObject {
    @Published var authURL: URL?
    @Published var isLoggedIn: Bool = false
    
    @AppStorage("isLoggedIn") var appStorageIsLoggedIn: Bool = false
    let keychain = Keychain(service: "com.mfeituri.beanify")
    
    // MARK: - PKCE Helpers
    func generateRandomString(length: Int) -> String {
        let possibleChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        var value = ""
        for _ in 0..<length {
            if let char = possibleChars.randomElement() {
                value.append(char)
            }
        }
        return value
    }
    
    func generateCodeChallenge(from verifier: String) -> String {
        let hashed = SHA256.hash(data: Data(verifier.utf8))
        let base64 = Data(hashed).base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
        return base64
    }
    
    // MARK: - Login
    func startLogin() {
        let codeVerifier = generateRandomString(length: 64)
        UserDefaults.standard.setValue(codeVerifier, forKey: "code_verifier")
        let codeChallenge = generateCodeChallenge(from: codeVerifier)
        
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
        
        if let url = components.url {
            self.authURL = url
        } else {
            print("Invalid URL")
        }
    }
    
    func handleRedirect(_ url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let code = components?.queryItems?.first(where: {$0.name == "code"})?.value {
            exchangeCodeForToken(code: code)
        } else {
            print("No authorization code")
        }
    }
    
    func exchangeCodeForToken(code: String) {
        guard
            let verifier = UserDefaults.standard.string(forKey: "code_verifier"),
            let url = URL(string: "https://accounts.spotify.com/api/token")
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyParams = [
            "client_id": Config.spotifyClientID,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": "beanify://callback",
            "code_verifier": verifier
        ]
        
        let bodyString = bodyParams
            .map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Token exchange error:", error)
                return
            }
            guard let data = data else { return }
            
            do {
                let tokenResponse = try JSONDecoder().decode(SpotifyTokenResponse.self, from: data)
                DispatchQueue.main.async {
                    do {
                        try self.keychain.set(tokenResponse.access_token, key: "access_token")
                    } catch {
                        print("Failed to save token", error)
                    }
                    self.fetchUserProfile()
                }
            } catch {
                print("Failed to decode token:", error)
            }
        }.resume()
    }
    
    // MARK: - Fetch User Profile
    func fetchUserProfile() {
        guard let token = try? keychain.get("access_token") else { return }
        guard let url = URL(string: "https://api.spotify.com/v1/me") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Profile fetch error:", error)
                return
            }
            guard let data = data else { return }
            
            do {
                let profile = try JSONDecoder().decode(SpotifyUserProfile.self, from: data)
                DispatchQueue.main.async {
                    print("Logged in as:", profile.displayName ?? profile.id)
                    self.isLoggedIn = true
                    self.appStorageIsLoggedIn = true  // ✅ this triggers RootView
                    self.authURL = nil
                }
            } catch {
                print("Failed to decode profile:", error)
            }
        }.resume()
    }
    

    
}
