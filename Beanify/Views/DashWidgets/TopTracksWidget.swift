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
                .frame(alignment: .center)
                .font(.headline)
                .padding(.bottom, 4)
            ForEach(Array(tracks.enumerated()), id: \.offset) { index, track in
                VStack(alignment: .center, spacing: 8){
                    Text("\(index + 1)")
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.leading, 8)
                        .frame(width: 30, alignment: .center)
                    VStack(alignment: .leading, spacing: 2){
                        Text(track.name)
                            .font(.subheadline)
                            .lineLimit(1)
                    }
                    
                    Text(track.artists.map{$0.name}.joined(separator: ", "))
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.leading, 4)
                        .frame(alignment: .center)
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
}
