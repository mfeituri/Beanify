//
//  DashboardVIew.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/24/25.
//

import Foundation
import SwiftUI



struct DashboardView: View{
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View{
        ZStack{
            LinearGradient(colors: [.green, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            ScrollView{
                VStack{
                    GroupBox{
                        ScrollView{
                            TopArtistsWidget(artists: viewModel.topArtists)
                                .padding()
                        }
                        
                    }
                    HStack{
                        GroupBox{
                            ScrollView{
                                TopTracksWidget(tracks: viewModel.topTracks)
                                    .padding()
                                   
                                
                            }
                        }
                    }
                }
                .task {
                    await viewModel.fetchArtistData()
                    await viewModel.fetchTrackData()
                }
            }
        }
    }
}


#Preview {
    DashboardView()
}
