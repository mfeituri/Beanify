//
//  SpotifyUserProfile.swift
//  Beanify
//
//  Created by Mohamed Feituri on 8/25/25.
//

// this is for getting the user profile info from spotify

struct SpotifyUserProfile: Codable {
    let id: String
    let displayName: String?
    let email: String?
}
