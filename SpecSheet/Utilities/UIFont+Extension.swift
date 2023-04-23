//
//  UIFont+Extension.swift
//  FBTime_Mobile
//
//  Created by Kraig Wastlund on 9/11/19.
//  Copyright © 2019 Fishbowl. All rights reserved.
//

import UIKit

extension UIFont {
    
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    func vanilla() -> UIFont {
        return withTraits(traits: UIFontDescriptor.SymbolicTraits(rawValue: 0))
    }
}
