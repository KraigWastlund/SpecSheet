//
//  Spec+CoreDataProperties.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/24/23.
//
//

import Foundation
import CoreData


extension Spec {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spec> {
        return NSFetchRequest<Spec>(entityName: "Spec")
    }

    @NSManaged public var id: UUID
    @NSManaged public var dateLastModified: Date
    @NSManaged public var dateCreated: Date
    @NSManaged public var dateArchived: Date?
    @NSManaged public var locationID: UUID
    @NSManaged public var createdBy: UUID
    @NSManaged public var title: String
    @NSManaged public var specDescription: String?
    @NSManaged public var category: String
    @NSManaged public var attachments: [String]?
    @NSManaged public var imageURLs: [String]?

}

extension Spec : Identifiable {

}
