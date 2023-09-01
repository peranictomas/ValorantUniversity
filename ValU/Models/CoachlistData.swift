//
//  CoachListData.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-11-25.
//

import Foundation

struct CoachListData: Identifiable {
    var id: String = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var coach: Bool
    var puuid: String
    var rating: String
}
