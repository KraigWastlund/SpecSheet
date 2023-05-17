//
//  ContentView.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/22/23.
//

import SwiftUI
import CoreData

struct HousesView: View {
    
    @Binding var path: NavigationPath
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.dateLastModified, ascending: true)],
        predicate: NSPredicate(format: "parentID == nil", argumentArray: nil),
        animation: .default)
    private var houses: FetchedResults<Location>

    var body: some View {
        List {
            ForEach(houses) { house in
                NavigationLink(value: house) {
                    VStack(alignment: .leading) {
                        Text(house.title)
                            .font(.title3)
                        Text("Date Created: \(house.dateCreated, formatter: itemFormatter)")
                            .font(.footnote)
                    }
                }
            }
            .onDelete(perform: deleteLocations)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .accentColor(.yellow)
            }
            ToolbarItem {
                Button(action: addLocation) {
                    Label("Add Item", systemImage: "plus")
                }
                .accentColor(.yellow)
            }
        }
    }

    private func addLocation() {
        // TODO: KRAIG -- PRESENT A CREATE LOCATION VIEW
        withAnimation {
            let newItem = Location(context: viewContext)
            newItem.dateCreated = Date()
            newItem.dateLastModified = Date()
            newItem.title = "Blah"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteLocations(offsets: IndexSet) {
        withAnimation {
            offsets.map { houses[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
