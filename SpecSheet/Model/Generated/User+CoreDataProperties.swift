//
//  User+CoreDataProperties.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/24/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID
    @NSManaged public var dateLastModified: Date
    @NSManaged public var dateCreated: Date
    @NSManaged public var dateArchived: Date?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var username: String
    @NSManaged public var phone: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var zip: String?

}

extension User : Identifiable {

}
