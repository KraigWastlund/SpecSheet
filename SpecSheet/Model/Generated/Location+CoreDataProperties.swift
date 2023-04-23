//
//  Location+CoreDataProperties.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/22/23.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var id: UUID
    @NSManaged public var parentID: UUID?
    @NSManaged public var title: String
    @NSManaged public var imageURLs: NSObject?
    @NSManaged public var locationDescription: String?
    @NSManaged public var dateCreated: Date
    @NSManaged public var dateLastModified: Date
    @NSManaged public var dateArchived: Date?

}

extension Location : Identifiable {

}
