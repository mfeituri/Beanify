//
//  LoginView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/23/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel // this is for login stuff
    
    var body: some View {
        ZStack {
            // this is the background gradient thingy
            LinearGradient(
                colors: [.purple.opacity(0.9), .green.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea() // make it go full screen
            
            VStack(spacing: 40) {
                
              
                Text("Beanify")
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                
            
                Image("kitty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                
                // this is the glass login card thing
                VStack(spacing: 20) {
                    Text("Sign in to get your top tracks & artists")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Button(action: viewModel.startLogin) {
                        HStack {
                            Image(systemName: "music.note.list") // little music icon
                            Text("Sign in with Spotify")
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(colors: [.green.opacity(0.8), .purple.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    }
                    
                }
                .padding()
                .background(.ultraThinMaterial) // this is the glass effect
                .cornerRadius(24)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 60)
            .padding(.bottom, 40)
        }
        // this makes the login sheet show when we get a url from spotify
        .sheet(isPresented: Binding(
            get: { viewModel.authURL != nil },
            set: { if !$0 { viewModel.authURL = nil } }
        )) {
            if let url = viewModel.authURL {
                SafariView(url: url)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
