//
//  LoginVIewModel.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/23/25.
//

import Foundation
import SwiftUI
import CryptoKit

class LoginViewModel: ObservableObject{
    
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
    
    func startLogin(){
        let codeVerifier = generateRandomString(length: 64)
        let codeChallenge = generateCodeChallenge(from: codeVerifier)
        
    }
    
    
}

