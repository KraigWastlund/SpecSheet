//
//  Color.swift
//  fbt-terminal-ios
//
//  Created by Kraig Wastlund on 2/26/19.
//  Copyright © 2019 Fishbowl. All rights reserved.
//

import Foundation
import UIKit
import DBC
import SwiftUI

extension Color {
    
    static var charcoal: Color {
        Color.fromHexString(hex: "101820")
    }
    
    static var yellow: Color {
        Color.fromHexString(hex: "FEE715")
    }
    
    static var lightCharcoal: Color {
        let charcoalUI = UIColor.fromHexString(hex: "101820")
        let lightCharcoal = UIColor.blend(color1: charcoalUI, intensity1: 1.0, color2: UIColor.white, intensity2: 0.15)
        return Color(uiColor: lightCharcoal)
    }
    
    static var lightYellow: Color {
        let yellowUI = UIColor.fromHexString(hex: "FEE715")
        let lightYellow = UIColor.blend(color1: yellowUI, intensity1: 1.0, color2: UIColor.white, intensity2: 0.25)
        return Color(uiColor: lightYellow)
    }
    
    static var darkYellow: Color {
        let yellowUI = UIColor.fromHexString(hex: "FEE715")
        let darkYellow = UIColor.blend(color1: yellowUI, intensity1: 1.0, color2: UIColor.black, intensity2: 0.25)
        return Color(uiColor: darkYellow)
    }
    
    private static func fromHexString(hex: String) -> Color {
        return Color(uiColor: UIColor.fromHexString(hex: hex))
    }
}

extension UIColor {
    
    static func fromHexString(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        guard cString.count == 6 else {
            requireFailure("hex string must be `hex` dummy.")
            return UIColor()
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    
    static func blend(color1: UIColor, intensity1: CGFloat = 0.5, color2: UIColor, intensity2: CGFloat = 0.5) -> UIColor {
        let total = intensity1 + intensity2
        let l1 = intensity1/total
        let l2 = intensity2/total
        guard l1 > 0 else { return color2}
        guard l2 > 0 else { return color1}
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
    }
}

