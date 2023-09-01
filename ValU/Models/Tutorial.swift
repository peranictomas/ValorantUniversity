//
//  Tutorial.swift
//  ValorantUniversity
//
//  Created by Rayan Syed on 2021-09-14.
//

import Foundation

struct Tutorial: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var agent: String
    var map: String
    var phase: String
    var tags: [String]
    var videoID: String
    var userEmail: String
}
