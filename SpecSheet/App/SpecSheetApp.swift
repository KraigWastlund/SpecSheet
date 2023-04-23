//
//  SpecSheetApp.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/22/23.
//

import SwiftUI

@main
struct SpecSheetApp: App {
    
    let persistenceController = PersistenceController.shared
    
    init() {
        setUIAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            SideNavAndRootModuleView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension SpecSheetApp {
    
    fileprivate func setUIAppearance() {
        
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
