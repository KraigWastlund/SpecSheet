//
//  RootModule.swift
//  Excalibur
//
//  Created by Kraig Wastlund on 1/25/23.
//

import Foundation

enum RootModule: String {
    case houses
    case archived
    case placeholder1
    case placeholder2
    
    var title: String {
        switch self {
        case .houses:
            return "Houses"
        case .archived:
            return "Archived"
        case .placeholder1:
            return "Placeholder 1"
        case .placeholder2:
            return "Placeholder 2"
        }
    }
}
