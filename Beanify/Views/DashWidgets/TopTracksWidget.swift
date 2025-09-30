//
//  TopTracksWidget.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/8/25.
//
import SwiftUI

struct TopTracksWidget: View {
    let tracks: [Tracks]
    
    var body: some View {
        VStack {
            Text("Top Tracks")
                .frame(alignment: .center)
                .font(.headline)
                .padding(.bottom, 4)
            
            ForEach(Array(tracks.enumerated()), id: \.offset) { index, track in
                HStack(alignment: .center, spacing: 12) {
                    
                    // track Index
                    Text("\(index + 1)")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 30, alignment: .center)
                    
                    //   shows the album cover
                    if let albumUrl = track.album.images.first?.url, let url = URL(string: albumUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                        }
                    }
                    
                    // shows the track Info
                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.name)
                            .font(.subheadline)
                            .lineLimit(1)
                            .foregroundColor(.white)
                        
                        Text(track.artists.map { $0.name }.joined(separator: ", "))
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
    }
}
