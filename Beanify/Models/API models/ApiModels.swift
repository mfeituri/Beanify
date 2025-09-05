//
//  TopTracks.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/4/25.
//
struct TopArtistResponse: Codable{
    let items: [Artist]
}
struct ExternalUrl: Codable, Identifiable{
    let spotify: String
    let id: String
    let name: String
    
}
struct Followers: Codable{
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
    
    struct Tracks: Codable, Identifiable {
        let id: String
        let name: String
    
    }
    
}
