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
        VStack{
            GroupBox{
                ScrollView{
                    TopArtistsWidget(artists: viewModel.topArtists)
                }
                .frame(width: 200 , height: 200)
                .padding(.horizontal)
                .padding(.vertical)
                
            }
            HStack{
                GroupBox{
                    
                    ScrollView{
                        TopArtistsWidget(artists: viewModel.topArtists)
                            .frame(width: 200, height: 200)
                            .padding(.horizontal)
                            .scaledToFit()
                    }
                }
            }
        }
        
        
        
    }
}


#Preview {
    DashboardView()
}
