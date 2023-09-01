//
//  MatchList.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-11-16.
//

import Foundation

struct MatchList: Codable {
    let puuid: String
    let history: [History]
}

struct History: Codable, Hashable {
    let matchId: String
    let gameStartTimeMillis: Int
}
