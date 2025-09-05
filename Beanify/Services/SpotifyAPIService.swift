//
//  SpotifyAPIService.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/4/25.
//
import Foundation
import KeychainAccess

enum TimeRange: String{
    case shortTerm = "short_term"
    case mediumTerm = "medium_term"
    case longTerm = "long_term"
}


class SpotifyAPIService { // swift ui classes are shared by reference, so we want to make sure states are saved vs views which are structs and they destroy and make copies on the fly
    
    // this is the base spotify url for all endpoints
    private let baseUrl = "https://api.spotify.com/v1"
    
    func getTokenAcess() -> String? {
        let keychain = Keychain(service: "com.mfeituri.beanify")
        return keychain["access_token"]
    }
   
    }

extension SpotifyAPIService{
    func getTopArtists(timerange: TimeRange = .mediumTerm, limit: Int = 25 ) async throws -> [Artist] {
       //these are the url components
        
        var components = URLComponents(string: "\(baseUrl)/me/top/artists")
        components?.queryItems = [
            URLQueryItem(name: "time_range", value: timerange.rawValue),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        // get the url
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        //create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //auth header
        if let token = getTokenAcess(){
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else{
            throw URLError(.userAuthenticationRequired)
        }
        
        //make the network call
        let (data, response) = try await URLSession.shared.data(for: request)
        // check the response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        //decode the json
        
        let topArtistResponse = try JSONDecoder().decode(TopArtistResponse.self, from: data)
        let artists = topArtistResponse.items
        
        return artists
        
    }
    
}

extension SpotifyAPIService{
    func getTopTracks() async throws -> [Tracks]
    
}
