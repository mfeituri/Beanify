//
//  TopArtistsWidget.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/5/25.
//

import SwiftUI

struct TopArtistsWidget: View{
   let artists: [Artist]
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Top Artists")
                .font(.headline)
                .padding(.bottom, 4)
            ForEach(artists) { artist in
                HStack {
                    AsyncImage(url: URL(string: artist.bestImage ?? "")) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } else if phase.error != nil {
                            Color.red.frame(width: 40, height: 40).clipShape(Circle())
                        } else {
                            ProgressView().frame(width: 40, height: 40)
                        }
                    }
                    Text(artist.name)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.leading, 8)
                    
                   
                }
                
            }
            
        }
        
    }
    
}


