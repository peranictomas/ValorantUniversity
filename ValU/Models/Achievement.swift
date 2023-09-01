//
//  Achievement.swift
//  ValU
//
//  Created by Rayan Syed on 2021-11-24.
//

import Foundation
import SwiftUI
struct Achievement: Identifiable{
    var id: String
    var title:String
    var description:String
    var unlocked:Bool
    var percentCompleted: CGFloat
    var score: Int
}
