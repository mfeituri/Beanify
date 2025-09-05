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
    private let apiService = SpotifyAPIService()
    
    func fetchArtistData() async {
        do{
            let artists = try await apiService.getTopArtists()
            DispatchQueue.main.async{
                self.topArtists = artists
            }
            
            } catch {
                print("error fetching artists: \(error)")
            }
        }
    }
    

