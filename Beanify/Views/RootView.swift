//
//  RootView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 8/27/25.
//
import SwiftUI

struct RootView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            TabNavigationView()
        } else {
            LoginView()
        }
    }
}

