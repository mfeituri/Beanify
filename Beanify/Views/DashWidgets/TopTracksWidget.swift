//
//  TopTracksWidget.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/8/25.
//
import SwiftUI

struct TopTracksWidget: View{
    let tracks: [Tracks]
    
    var body: some View {
        
        VStack{
            Text("Top Tracks")
                .font(.headline)
                .padding(.bottom, 4)
            ForEach(tracks) { track in
                HStack{
                    Text(track.name)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.leading, 8)
                    
                    Text(track.artists.map{$0.name}.joined(separator: ", "))
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.leading, 4)
                }
            }
        }
    }
}
