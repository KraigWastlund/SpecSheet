//
//  LocationView.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/23/23.
//

import SwiftUI

enum LocationType {
    case root
    case branch
    case leaf
}

struct LocationView: View {
    
    init(path: Binding<NavigationPath>, location: Location) {
        _path = path
        self.location = location
        _subLocations = FetchRequest<Location>(sortDescriptors: [NSSortDescriptor(keyPath: \Location.dateLastModified, ascending: true)],
                                               predicate: NSPredicate(format: "parentID == %@", argumentArray: [location.id]),
                                               animation: .default)
        _specs = FetchRequest<Spec>(sortDescriptors: [NSSortDescriptor(keyPath: \Spec.dateLastModified, ascending: true)],
                                    predicate: NSPredicate(format: "locationID == %@", argumentArray: [location.id]),
                                    animation: .default)
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest var subLocations: FetchedResults<Location>
    @FetchRequest var specs: FetchedResults<Spec>
    
    @State private var selectedPage = 0
    
    @Binding var path: NavigationPath
    let location: Location
    lazy var type: LocationType = location.parentID == nil ? .root : subLocations.isEmpty ? .leaf : .branch
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string:(location.imageURLs!).first!),
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
                Text(location.locationDescription ?? "No Description")
                    .font(.footnote)
                    .lineLimit(nil)
                    .padding(.horizontal, 8)
            }
            .frame(height: 80)
            
            MiddleSection(selectedPage: $selectedPage)
            
            if selectedPage == 0 {
                SubLocationsList(subLocations: subLocations)
            }
            
            if selectedPage == 1 {
                SpecsList(specs: specs)
            }
        }
        .navigationTitle(location.title)
    }
}

private struct MiddleSection: View {
    @Binding var selectedPage: Int
    
    var body: some View {
        Picker("", selection: $selectedPage) {
            Text("Rooms").tag(0)
            Text("Specs").tag(1)
        }
        .pickerStyle(.segmented)
    }
}

private struct SubLocationsList: View {
    
    let subLocations: FetchedResults<Location>
    
    var body: some View {
        List {
            if subLocations.isEmpty {
                SubLocationRow(location: Location.emptyLocation)
            } else {
                ForEach(subLocations) { room in
                    NavigationLink(value: room) {
                        SubLocationRow(location: room)
                    }
                }
            }
        }
    }
    
    struct SubLocationRow: View {
        
        let location: Location
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(location.title)
                    .font(.title3)
                Text(location.locationDescription ?? "No Description")
                    .font(.footnote)
            }
        }
    }
}

private struct SpecsList: View {
    
    let specs: FetchedResults<Spec>
    
    var body: some View {
        List {
            if specs.isEmpty {
                SpecRow(spec: Spec.emptySpec)
            } else {
                ForEach(specs) { spec in
                    NavigationLink(value: spec) {
                        SpecRow(spec: spec)
                    }
                }
            }
        }
    }
    
    struct SpecRow: View {
        
        let spec: Spec
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(spec.title)
                    .font(.title3)
                Text(spec.specDescription ?? "No Description")
                    .font(.footnote)
            }
        }
    }
}
