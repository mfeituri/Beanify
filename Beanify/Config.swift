//
//  Config.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/4/25.
//

import Foundation

enum Config {
    static var spotifyClientID: String {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
            let clientId = dict["SPOTIFY_CLIENT_ID"] as? String
        else {
            fatalError("Missing SPOTIFY_CLIENT_ID in Config.plist")
        }
        return clientId
    }
}
