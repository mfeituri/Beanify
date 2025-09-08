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
        VStack(alignment: .leading){
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
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .padding(.leading, 8)
                    }
                
            }

        }
        
    }
    
}

extension Artist {
    static let mocks: [Artist] = [
        Artist(
            id: "2",
            name: "Nirvana",
            popularity: 90,
            genres: ["grunge", "rock"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 15_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/6olE6TJLqED3rqDCT0FyPh",
                id: "4",
                name: "nirvana-spotify"
            )
        ),
        Artist(
            id: "3",
            name: "The Weeknd",
            popularity: 95,
            genres: ["pop", "r&b"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/0/09/The_Weeknd_-_After_Hours.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 40_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ",
                id: "5",
                name: "weeknd-spotify"
            )
        ),
        Artist(
            id: "4",
            name: "Radiohead",
            popularity: 92,
            genres: ["alternative", "rock"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/b/ba/Radioheadokcomputer.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 20_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/4Z8W4fKeB5YxbusRsdQVPb",
                id: "6",
                name: "radiohead-spotify"
            )
        ),
        Artist(
            id: "5",
            name: "Kendrick Lamar",
            popularity: 98,
            genres: ["hip hop", "rap"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/9/95/Kendrick_Lamar_-_DAMN.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 35_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/2YZyLoL8N0Wb9xBt1NhZWg",
                id: "7",
                name: "kendrick-spotify"
            )
        ),
        Artist(
            id: "6",
            name: "Billie Eilish",
            popularity: 96,
            genres: ["pop", "electropop"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/7/70/Billie_Eilish_-_When_We_All_Fall_Asleep%2C_Where_Do_We_Go%3F.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 50_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/6qqNVTkY8uBg9cP3Jd7DAH",
                id: "8",
                name: "billie-spotify"
            )
        ),
        Artist(
            id: "7",
            name: "Tame Impala",
            popularity: 88,
            genres: ["psychedelic rock", "indie"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/4/45/Tame_Impala_-_Currents.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 8_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/5INjqkS1o8h1imAzPqGZBb",
                id: "9",
                name: "tame-spotify"
            )
        ),
        Artist(
            id: "8",
            name: "Arctic Monkeys",
            popularity: 91,
            genres: ["indie rock", "alternative"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/0/04/Arctic_Monkeys_-_AM.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 18_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/7Ln80lUS6He07XvHI8qqHH",
                id: "10",
                name: "arctic-spotify"
            )
        ),
        Artist(
            id: "9",
            name: "Taylor Swift",
            popularity: 100,
            genres: ["pop", "country"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/f/f6/Taylor_Swift_-_1989.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 80_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/06HL4z0CvFAxyc27GXpf02",
                id: "11",
                name: "taylor-spotify"
            )
        ),
        Artist(
            id: "10",
            name: "Drake",
            popularity: 99,
            genres: ["rap", "hip hop", "pop"],
            images: [
                SpotifyImage(
                    url: "https://upload.wikimedia.org/wikipedia/en/7/74/Drake_-_Scorpion.png",
                    height: 640,
                    width: 640
                )
            ],
            followers: Followers(total: 65_000_000),
            external_urls: ExternalUrl(
                spotify: "https://open.spotify.com/artist/3TVXtAsR1Inumwj472S9r4",
                id: "12",
                name: "drake-spotify"
            )
        )
    ]
}




#Preview {
    TopArtistsWidget(artists: Artist.mocks)
}
