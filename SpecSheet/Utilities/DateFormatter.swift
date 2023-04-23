//
//  DateFormatter.swift
//  fbt-terminal-ios
//
//  Created by Kraig Wastlund on 3/6/19.
//  Copyright © 2019 Fishbowl. All rights reserved.
//

import Foundation

// valid date format from Grainger:
// "2019-04-10T23:03:07.928Z"

// utility
class TimeDate: DateFormatter {
    
    private static let kCachedDateFormatterKey = "CachedDateFormatterKey"
    public static var dateFormatter:  DateFormatter {
        let threadDictionary = Thread.current.threadDictionary
        var dateFormatter = threadDictionary[kCachedDateFormatterKey] as? DateFormatter
        
        if dateFormatter == nil {
            dateFormatter = DateFormatter()                        // 2019-02-25T17:24:00Z
            dateFormatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" // "2019-02-27T18:21:13.12Z" <-- example from FB
            
            //make sure you format the date in GMT (what the server stores it as)
            dateFormatter?.timeZone = TimeZone(abbreviation: "GMT")
            threadDictionary[kCachedDateFormatterKey] = dateFormatter
        }
        
        return dateFormatter!
    }
}

fileprivate extension Date {
    // because FB server sometimes sends this format: "2019-02-27T18:21:13.12Z" and sometimes this format: "2019-02-25T17:24:00Z"
    // we need to strip away anything after a possible `.` and `Z`
    static func stripFractionalSeconds(fromDateString str: String) -> String {
        guard str.contains(".") else { return str }
        
        let dotIndex = str.firstIndex(of: ".")!
        return str[..<dotIndex] + "Z"
    }
}
