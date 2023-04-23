//
//  HouseView.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/23/23.
//

import SwiftUI

struct HouseView: View {
    
    init(house: Location) {
        self.house = house
        _rooms = FetchRequest<Location>(sortDescriptors: [NSSortDescriptor(keyPath: \Location.dateLastModified, ascending: true)],
                                        predicate: NSPredicate(format: "parentID == %@", argumentArray: [house.id]),
                                               animation: .default)
    }
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest var rooms: FetchedResults<Location>
    
    @State private var selectedPage = 0
    
    let house: Location
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string:(house.imageURLs as! [String]).first!),
                content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                },
                placeholder: {
                    Text("imagehere")
                }
            )
            .frame(maxWidth: .infinity, maxHeight: 200)
            
            ScrollView(.vertical) {
                Text(house.locationDescription ?? "No Description")
                    .font(.footnote)
                    .lineLimit(nil)
                    .padding(.horizontal, 8)
            }
            .frame(height: 80)
            
            Picker("", selection: $selectedPage) {
                Text("Rooms").tag(0)
                Text("Specs").tag(1)
            }
            .pickerStyle(.segmented)
            
            if selectedPage == 0 {
                List {
                    ForEach(rooms) { room in
                        NavigationLink {
                            VStack {
                                Text(room.title)
                                    .font(.title2)
                                Text(room.locationDescription ?? "No Description")
                                    .font(.footnote)
                            }
                            .navigationTitle(room.title)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(room.title)
                                    .font(.title3)
                                Text("Date Created: \(room.dateCreated, formatter: itemFormatter)")
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
            
            if selectedPage == 1 {
                List {
                    Text("Spec One")
                        .font(.body)
                    Text("Spec Two")
                        .font(.body)
                    Text("Spec Three")
                        .font(.body)
                    Text("Spec Four")
                        .font(.body)
                    Text("Spec Five")
                        .font(.body)
                }
            }
        }
        .navigationTitle(house.title)
    }
}
