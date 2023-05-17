//
//  Spec+CoreDataClass.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/24/23.
//
//

import Foundation
import CoreData

@objc(Spec)
public class Spec: NSManagedObject {

    static var emptySpec: Spec {
        let spec = Spec(context: PersistenceController.tempContext)
        spec.title = "Empty Spec"
        spec.specDescription = ""
        
        return spec
    }
}
