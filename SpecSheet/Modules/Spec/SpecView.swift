//
//  SpecView.swift
//  SpecSheet
//
//  Created by Kraig Wastlund on 4/24/23.
//

import SwiftUI

struct SpecView: View {
    
    @Binding var path: NavigationPath
    let spec: Spec
    
    var body: some View {
        ScrollView {
            Text(spec.title)
            Text(spec.specDescription ?? "No Description")
            Text(spec.createdBy.uuidString)
                .navigationTitle(spec.title)
        }
    }
}
