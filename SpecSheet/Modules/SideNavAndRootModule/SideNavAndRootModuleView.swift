//
//  SideNavAndMainContentView.swift
//  Excalibur
//
//  Created by Kraig Wastlund on 1/18/23.
//

import SwiftUI

struct SideNavAndRootModuleView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    //    @EnvironmentObject var context: AppContext
    
    @State var showSideNav: Bool = false
    @State var rootModule: RootModule = .houses
    
    var body: some View {
        ZStack {
            RootModuleNavStackView(showSideNav: $showSideNav, rootModule: rootModule)
            SideNavContainerView(showSideNav: $showSideNav, rootModule: rootModule, selected: { moduleSelected in
                rootModule = moduleSelected
                showSideNav = false
            })
            .offset(x: CGFloat(showSideNav ? 0.0 : -UIScreen.main.bounds.size.width))
            .animation(.easeOut, value: showSideNav)
        }
    }
}
