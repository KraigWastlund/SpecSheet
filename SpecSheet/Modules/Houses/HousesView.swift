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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                } label: {
                    Text(item.timestamp!, formatter: itemFormatter)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .accentColor(.yellow)
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                .accentColor(.yellow)
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// TODO: KRAIG - JUST ADDED CORE DATA MODEL - GET THE ABOVE LIST FETCHING IT AFTER YOU MAKE SOME TEMP DATA IN APP FILE

struct Location {
    let id: UUID
    let parentId: UUID?
    let title: String
    let imageUrls: [URL]
    let description: String = ""
    let dateLastModified = Date()
    let dateCreated = Date()
    let dateArchived: Date? = nil
}

private func buildData() -> [Location] {
    
    var locations = [Location]()
    
    for i in 0...10 {
        let id = UUID()
        let house = Location(id: id, parentId: nil, title: "House \(i)", imageUrls: [])
        let parentId = id
        for j in 0...10 {
            let roomId = UUID()
            let room = Location(id: roomId, parentId: parentId, title: "Room \(j)", imageUrls: [])
            locations.append(room)
        }
        locations.append(house)
    }
    
    return locations
}
