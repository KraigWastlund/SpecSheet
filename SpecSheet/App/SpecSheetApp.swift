//
//  SpecSheetApp.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/22/23.
//

import SwiftUI
import CoreData

@main
struct SpecSheetApp: App {
    
    let persistenceController = PersistenceController.shared
    
    init() {
        setUIAppearance()
        setupData()
    }
    
    var body: some Scene {
        WindowGroup {
            SideNavAndRootModuleView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension SpecSheetApp {
    
    private func setupData() {
        let fr = Location.fetchRequest()
        if let locations = try? persistenceController.container.viewContext.fetch(fr) {
            if locations.isEmpty {
                let userId = buildUsers(with: persistenceController.container.viewContext)
                buildLocationsAndSpecs(with: persistenceController.container.viewContext, for: userId)
            }
        }
    }
    
    private func buildUsers(with context: NSManagedObjectContext) -> UUID {
        let user = User(context: context)
        user.id = UUID()
        user.dateCreated = Date()
        user.dateLastModified = Date()
        user.firstName = "Bob"
        user.lastName = "Marley"
        user.username = "bmarley"
        try! context.obtainPermanentIDs(for: [user])
        try! context.save()
        
        return user.id
    }
    
    private func buildLocationsAndSpecs(with context: NSManagedObjectContext, for userId: UUID) {
        var locations = [Location]()
        for i in 1...10 {
            let house = Location(context: context)
            house.id = UUID()
            house.dateCreated = Date()
            house.dateLastModified = Date()
            house.title = "House \(i)"
            house.imageURLs = ["https://picsum.photos/200/300?random=\(i)"] as [String]
            house.locationDescription = """
            This stunning house boasts 4 spacious bedrooms and 3 beautifully appointed bathrooms, making it the perfect home for a growing family or those who love to entertain guests. As you approach the front of the house, you'll be greeted by a grand circular driveway, which not only provides ample parking space but also adds a touch of elegance to the property.

            Upon entering the front door, you'll be welcomed into a bright and airy foyer that leads to the rest of the house. To your left, you'll find a cozy living room with large windows that let in plenty of natural light. To your right, you'll find a formal dining room that's perfect for hosting dinner parties.

            As you continue through the house, you'll come to a spacious and modern kitchen that's equipped with high-end appliances and plenty of storage space. The kitchen opens up to a comfortable family room, which is the perfect place to relax with family and friends.

            The bedrooms in this house are located on the upper level and offer plenty of space and privacy. The master bedroom features a large en-suite bathroom with a luxurious soaking tub and a separate shower. The other bedrooms are also generously sized and share two additional bathrooms.

            One of the standout features of this house is the large backyard, which provides a perfect place for outdoor activities and entertaining. The backyard is beautifully landscaped and features a variety of plants, trees, and flowers. There's also a patio area with plenty of seating space and a grill, making it the perfect spot for summer barbecues and outdoor parties.

            Overall, this house offers a perfect combination of luxury, comfort, and style. With its spacious bedrooms, modern amenities, and beautiful outdoor space, it's the perfect place to call home.
            """
            locations.append(house)
            
            // Specs
            
            let titlesAndCategories: [String:String] = ["GE Fridge 3443": "Appliance", "Redwood Flooring Model 333W": "Flooring", "Kwal Howels - Sunset Green": "Paint", "Garrett's Cabinets": "Cabinets"]
            
            for _ in 1...10 {
                let titleAndCategory = titlesAndCategories.randomElement()!
                let spec = Spec(context: context)
                spec.id = UUID()
                spec.locationID = house.id
                spec.title = titleAndCategory.key
                spec.category = titleAndCategory.value
                spec.createdBy = userId
                spec.dateCreated = Date()
                spec.dateLastModified = Date()
                spec.specDescription = """
                This is the long description for this specificiation.  This might tell the sub contractor special instructions regarding this specification.
                This is the descrioption for the \(spec.title) spec for house \(i)
                """
            }
            
            // Rooms
            
            for j in 1...10 {
                let room = Location(context: context)
                room.id = UUID()
                room.parentID = house.id
                room.dateCreated = Date()
                room.dateLastModified = Date()
                room.title = "Room \(j)"
                room.locationDescription = "This is the room number \(j) in house \(i).  Here's some more text just to make it more interesting."
                room.imageURLs = ["https://picsum.photos/200/300?random=\(i + j)", "https://picsum.photos/200/300?random=\(i + j)", "https://picsum.photos/200/300?random=\(i + j)"] as [String]
                locations.append(room)
                
                for m in 1...10 {
                    let subLocation = Location(context: context)
                    subLocation.id = UUID()
                    subLocation.parentID = room.id
                    subLocation.dateCreated = Date()
                    subLocation.dateLastModified = Date()
                    subLocation.title = "Sub Location \(m)"
                    subLocation.locationDescription = "This is the sub location for room \(j) in house \(i).  Here's the awesome description of this sub location. :)"
                    subLocation.imageURLs = ["https://picsum.photos/200/300?random=\(m + i + j)", "https://picsum.photos/200/300?random=\(m + i + j + 1)", "https://picsum.photos/200/300?random=\(m + i + j + 2)"] as [String]
                }
            }
        }
        
        try! context.obtainPermanentIDs(for: locations)
        try! context.save()
    }
    
    private func setUIAppearance() {
        
        // Nav bar - background and line at bottom
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(Color.charcoal)
        navBarAppearance.shadowColor = UIColor(Color.charcoal)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.yellow)]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UISearchBar.appearance().backgroundColor = UIColor(Color.lightCharcoal)
    }
}
