//
//  Config.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/4/25.
//

import Foundation

// this file is to hide the client key and abstract it from the rest of the code so it cant be read
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
