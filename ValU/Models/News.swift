//
//  News.swift
//  ValU
//
//  Created by Rayan Syed on 2021-11-09.
//

import Foundation

struct News: Identifiable {
    var id: String = UUID().uuidString
    var category: String
    var author: String
    var content: String
    var heading: String
    var image: String
}
