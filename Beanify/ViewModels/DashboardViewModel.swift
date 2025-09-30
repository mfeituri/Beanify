//
//  DashboardViewModel.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/24/25.
//

import Foundation
import SwiftUI


@MainActor
class DashboardViewModel: ObservableObject{
    @Published var topArtists: [Artist] = []
    @Published var topTracks: [Tracks] = []
    @Published var selectedTerm: TimeRange = TimeRange.shortTerm
   

    private let apiService = SpotifyAPIService()
    


    func fetchArtistData() async {
        do{
            let artists = try await apiService.getTopArtists(timeRange: selectedTerm)
                self.topArtists = artists
            
            } catch {
                print("error fetching artists: \(error)")
            }
        }
    
    func fetchTrackData() async {
        do{
            let tracks = try await apiService.getTopTracks(timeRange: selectedTerm)
                self.topTracks = tracks
            
        } catch {
            print("error fetching tracks: \(error)")
            
        }
    }
    }
    

