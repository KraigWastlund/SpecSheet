//
//  RootModuleView.swift
//  Excalibur
//
//  Created by Kraig Wastlund on 1/18/23.
//

import SwiftUI

struct RootModuleView: View {
    let rootModule: RootModule
    @Binding var path: NavigationPath // TODO: Move to EnvironmentObject
    
//    @EnvironmentObject var context: AppContext
    
    var body: some View {
        Group {
            switch rootModule {
            case .houses:
                HousesView(path: $path)
                    .navigationTitle(rootModule.title)
            case .archived:
                Text("archived")
                    .navigationTitle(rootModule.title)
            case .placeholder1:
                Text("placholder1")
                    .navigationTitle(rootModule.title)
            case .placeholder2:
                Text("placeholder2")
                    .navigationTitle(rootModule.title)
            }
        }
    }
}
