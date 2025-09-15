//
//  SpotifyAPIService.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/4/25.
//

// this is file is basically how we communicate with spotifys apis. it has the network requests for the various types of data
import Foundation
import KeychainAccess
import SwiftUI





class SpotifyAPIService { // swift ui classes are shared by reference, so we want to make sure states are saved vs views which are structs and they destroy and make copies on the fly
    
    // this is the base spotify url for all endpoints
    private let baseUrl = "https://api.spotify.com/v1"
    
    func getTokenAcess() -> String? {
        let keychain = Keychain(service: "com.mfeituri.beanify")
        return keychain["access_token"]
    }
    
}

extension SpotifyAPIService{
    func getTopArtists(timeRange: TimeRange = TimeRange.shortTerm , limit: Int = 25 ) async throws -> [Artist] {
        //these are the url components
        
        var components = URLComponents(string: "\(baseUrl)/me/top/artists")
        components?.queryItems = [
            URLQueryItem(name: "time_range", value: timeRange.rawValue),
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

// api request for getting top tracks
extension SpotifyAPIService{
    // these are the params required to send to the server
    func getTopTracks(timeRange: TimeRange = .shortTerm, limit: Int = 25)  async throws -> [Tracks]{
        // need to form the url string off base string, URL components helps alot with this
        var components =
        URLComponents(string: "\(baseUrl)/me/top/tracks")
        
        components?.queryItems = [
            URLQueryItem(name: "time_range", value: timeRange.rawValue),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        // make sure we have a valid url
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        //make the request method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        // need to authorize our token with spotify servers
        if let token = getTokenAcess(){
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let (data, response) = try await
        URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        let topTracksResponse = try
        JSONDecoder()
            .decode(TopTracksResponse.self, from: data)
        
        let tracks = topTracksResponse.items
        
        return tracks
    }
    
}
// get the user profile data from the api
extension SpotifyAPIService{
    
}
