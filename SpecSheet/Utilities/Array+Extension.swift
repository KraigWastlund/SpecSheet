//
//  Array+Extension.swift
//  FBTime_Mobile
//
//  Created by Kraig Wastlund on 12/5/19.
//  Copyright © 2019 Fishbowl. All rights reserved.
//

import Foundation

extension Array {
    func element(at i: Index) -> Element? {
        return i < count ? self[i] : nil
    }
}

extension Array where Element: Hashable {
    private func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
