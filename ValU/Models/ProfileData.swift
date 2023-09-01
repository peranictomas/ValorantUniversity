//
//  ProfileData.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-28.
//

import Foundation

struct ProfileData: Identifiable {
    var id: String = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var coach: Bool
    var puuid: String
    var rating: String
}
