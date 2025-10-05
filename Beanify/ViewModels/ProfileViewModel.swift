//
//  ProfileViewModel.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/15/25.
//

import KeychainAccess
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isDarkMode = false
    @Published var notificationsEnabled = true
    
    let keychain = Keychain(service: "com.mfeituri.beanify")
    

    @AppStorage("isLoggedIn") var appStorageIsLoggedIn: Bool = false
    
    // logout
    func logout() {
        print("Logging out…") // print for debugging
        
        // remove the Spotify access token
        do {
            try keychain.remove("access_token")
            print("Access token removed")
        } catch {
            print("Failed to remove token:", error)
        }
        
        // set AppStorage to false so RootView switches to LoginView
        appStorageIsLoggedIn = false
    }
    
    func openPortfolio() {
        if let url = URL(string: "https://mfeituri.github.io") {
            UIApplication.shared.open(url)
        }
    }
}
