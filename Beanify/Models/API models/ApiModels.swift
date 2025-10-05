//
//  TopTracks.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/4/25.
//
// file for all my api structs

import Foundation
import SwiftUI


struct SpotifyUserProfile: Codable {
    let id: String
    let displayName: String
    let email: String?
    let followers: Followers
    let externalUrls: ExternalUrl
    let images: [SpotifyImage]
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case email
        case followers
        case externalUrls = "external_urls"
        case images
        case country
    }
}


struct TopArtistResponse: Codable{
    let items: [Artist]
}

struct TopTracksResponse: Codable {
    let items: [Tracks]
}
struct ExternalUrl: Codable{
    let spotify: String
    
}

struct Followers: Codable {
    let total: Int
}

struct SpotifyImage: Codable {
    let url: String
    let height: Int
    let width: Int
}

struct Artist: Codable, Identifiable {
    let id: String
    let name: String
    let popularity: Int
    let genres: [String]
    let images: [SpotifyImage]
    let followers: Followers
    let external_urls: ExternalUrl
    
    var bestImage: String?{
        images.max(by: {$0.height > $1.height})?.url //better than sorting since it will do it on the first pass
    }
    
}

struct PieSlice: Identifiable {
    let id = UUID()
    let color: Color
    let value: Double
    let label: String
}


//dont want to use the same struct as top artists since its not the same structure
struct ArtistSimplified: Codable, Identifiable {
    let id: String
    let name: String
    let genres: [String]? // optional, may need to fetch full Artist from API
}


struct Album: Codable{
    let name: String
    let images: [SpotifyImage]
}



//identifiable makes it easier when writing foreach loops so i dont need an id for each, it does it on its own
struct Tracks: Codable, Identifiable {
    let id: String
    let name: String
    let album: Album
    let artists: [ArtistSimplified]
    let preview_url: String?
    

    struct PieSlice: Identifiable {
        let id = UUID()
        let color: Color
        let value: Double
        let label: String
    }

    
}
