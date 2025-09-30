//
//  ProfileView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/12/25.
//


import SwiftUI

struct ProfileView: View {
    @State private var userProfile: SpotifyUserProfile?
    @State private var errorMessage: String?
    
    @StateObject private var vm = ProfileViewModel() // handle logout, toggles
    
    private let apiService = SpotifyAPIService()
    
    var body: some View {
        ZStack {
            //background gradient
            LinearGradient(colors: [.purple.opacity(0.6), .green.opacity(0.6)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // profile Card
                    if let user = userProfile {
                        VStack(spacing: 16) {
                            // profile Picture
                            if let imageUrl = user.images.first?.url {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.green, lineWidth: 3))
                                        .shadow(radius: 6)
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 140, height: 140)
                                    .foregroundColor(.gray)
                            }
                            
                            Text(user.displayName)
                                .font(.title)
                                .bold()
                            
                            if let email = user.email {
                                Text(email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Stats
                            HStack(spacing: 24) {
                                VStack {
                                    Text("\(user.followers.total)")
                                        .bold()
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                VStack {
                                    Text(user.id)
                                        .lineLimit(1)
                                        .truncationMode(.middle)
                                    Text("User ID")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                VStack {
                                    Text(user.country ?? "—")
                                    Text("Country")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Link(destination: URL(string: user.externalUrls.spotify)!) {
                                Label("View on Spotify", systemImage: "link")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20)) // liquid glass
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    
                    //  settings Section
                    VStack(spacing: 16) {
                        
                        
                        Button("Logout") {
                            vm.logout()
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                } // VStack
                .padding(.vertical)
            } // ScrollView
        } // ZStack
        .task {
            do {
                userProfile = try await apiService.getCurrentUserProfile()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview{
    ProfileView()
}
