//
//  ResponseData.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/27/25.
//

import Foundation

struct SpotifyTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
}
