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
        List(viewModel.topArtists){ artist in
            Text(artist.name)
                
            
        }
        .task{
            await viewModel.fetchArtistData()
        }
        
    }
}

#Preview {
    DashboardView()
}
