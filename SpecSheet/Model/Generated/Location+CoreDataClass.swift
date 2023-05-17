//
//  Location+CoreDataClass.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/22/23.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {

    static var emptyLocation: Location {
        let location = Location(context: PersistenceController.tempContext)
        location.title = "Empty Location"
        location.locationDescription = ""
        
        return location
    }
}
