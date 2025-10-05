//
//  DataViewModel.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/15/25.
//
import SwiftUI
@MainActor
class DataViewModel: ObservableObject {
    @Published var topGenres: [String: Int] = [:] // genre -> count

    init(tracks: [Tracks]) {
        calculateGenres(from: tracks)
    }

    // temporary genre simulation until real Spotify genres are fetched
    func calculateGenres(from tracks: [Tracks]) {
        var counts: [String: Int] = [:]
        let sampleGenres = ["Pop", "Rock", "Hip-Hop", "EDM", "R&B", "Indie"]

        for (i, track) in tracks.enumerated() {
            // Assign a genre from sampleGenres in a round-robin fashion
            let genre = sampleGenres[i % sampleGenres.count]
            counts[genre, default: 0] += 1
        }

        topGenres = counts
    }

    func makeSlices() -> [PieSlice] {
        let total = topGenres.values.reduce(0, +)
        let colors: [Color] = [.green, .purple, .mint, .orange, .pink, .yellow]
        var i = 0

        return topGenres.map { genre, count in
            let slice = PieSlice(
                color: colors[i % colors.count],
                value: Double(count) / Double(total),
                label: genre
            )
            i += 1
            return slice
        }
    }
}
