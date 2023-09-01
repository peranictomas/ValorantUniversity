//
//  MatchInfo.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-11-16.
//

import Foundation

struct MatchInfoResponse: Codable {
    let matchInfo: MatchInfo
    let players: [Player]
    let roundResults: [RoundResult]
}

struct MatchInfo: Codable, Hashable {
    let matchId: String
    let mapId: String
    let gameLengthMillis: Int
    let gameStartMillis: Int
    let provisioningFlowId: String
    let isCompleted: Bool
    let queueId: String
    let gameMode: String
    let isRanked: Bool
    let seasonId: String
}

struct Player: Codable {
    let puuid: String
    let gameName: String
    let tagLine: String
    let teamId: String
    let partyId: String
    let characterId: String
    let stats: Stats
    let competitiveTier: Int
}

struct Stats: Codable {
    let score: Int
    let roundsPlayed: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let playtimeMillis: Int
    let abilityCasts: AbilityCasts
}

struct AbilityCasts: Codable {
    let grenadeCasts: Int
    let ability1Casts: Int
    let ability2Casts: Int
    let ultimateCasts: Int
}

struct RoundResult: Codable {
    let playerStats: [PlayerStats]
}

struct PlayerStats: Codable {
    let puuid: String
    let score: Int
    let damage: [Damage]
}

struct Damage: Codable {
    let receiver: String
    let damage: Int
    let headshots: Int
}

struct MatchPlayers {
    let gameName: String
    let tagLine: String
    let competitiveTier: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let score: Int
}

struct GamePlayer: Hashable{
    //var id: String = UUID().uuidString'
    let puuid: String
    let gameName: String
    let tagLine: String
    let competitiveTier: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let score: Int
    let characterID: String
    let teamID: String
}
