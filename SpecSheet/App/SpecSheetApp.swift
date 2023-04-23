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
                buildLocations(with: persistenceController.container.viewContext)
            }
        }
    }
    
    private func buildLocations(with context: NSManagedObjectContext) {
        var locations = [Location]()
        for i in 1...10 {
            let house = Location(context: context)
            house.id = UUID()
            house.dateCreated = Date()
            house.dateLastModified = Date()
            house.title = "House \(i)"
            house.imageURLs = ["https://picsum.photos/200/300?random=\(i)"] as NSObject
            house.locationDescription = """
            This stunning house boasts 4 spacious bedrooms and 3 beautifully appointed bathrooms, making it the perfect home for a growing family or those who love to entertain guests. As you approach the front of the house, you'll be greeted by a grand circular driveway, which not only provides ample parking space but also adds a touch of elegance to the property.

            Upon entering the front door, you'll be welcomed into a bright and airy foyer that leads to the rest of the house. To your left, you'll find a cozy living room with large windows that let in plenty of natural light. To your right, you'll find a formal dining room that's perfect for hosting dinner parties.

            As you continue through the house, you'll come to a spacious and modern kitchen that's equipped with high-end appliances and plenty of storage space. The kitchen opens up to a comfortable family room, which is the perfect place to relax with family and friends.

            The bedrooms in this house are located on the upper level and offer plenty of space and privacy. The master bedroom features a large en-suite bathroom with a luxurious soaking tub and a separate shower. The other bedrooms are also generously sized and share two additional bathrooms.

            One of the standout features of this house is the large backyard, which provides a perfect place for outdoor activities and entertaining. The backyard is beautifully landscaped and features a variety of plants, trees, and flowers. There's also a patio area with plenty of seating space and a grill, making it the perfect spot for summer barbecues and outdoor parties.

            Overall, this house offers a perfect combination of luxury, comfort, and style. With its spacious bedrooms, modern amenities, and beautiful outdoor space, it's the perfect place to call home.
            """
            
            for j in 1...10 {
                let room = Location(context: context)
                room.id = UUID()
                room.parentID = house.id
                room.dateCreated = Date()
                room.dateLastModified = Date()
                room.title = "Room \(j)"
                room.locationDescription = "This is the room number \(j) in house \(i)"
                room.imageURLs = ["https://picsum.photos/200/300?random=\(i + j)", "https://picsum.photos/200/300?random=\(i + j)", "https://picsum.photos/200/300?random=\(i + j)"] as NSObject
                locations.append(room)
            }
            locations.append(house)
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
