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
            LinearGradient(colors:
                            [.green, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            ScrollView{
                HStack{
                    GroupBox{
                        ScrollView{
                            TopArtistsWidget(artists: viewModel.topArtists)
                                .padding()
                        }
                        
                        
                    }
                    GroupBox{
                        ScrollView{
                            TopTracksWidget(tracks: viewModel.topTracks)
                                .padding()
                        }
                    }
                }
                
            }
            //load the data from spotify api
            .task {
                await viewModel.fetchArtistData()
                await viewModel.fetchTrackData()
            }
            .padding(.top, 0.2)
            .padding(.bottom,0.2)
        }
        
    }
}



#Preview {
    DashboardView()
}
