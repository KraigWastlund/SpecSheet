//
//  RootModuleView.swift
//  Excalibur
//
//  Created by Kraig Wastlund on 1/18/23.
//

import SwiftUI

let closeKeyboardNotification = NSNotification.Name(rawValue: "closeAnyKeyboards")
let publisherForClosingTheKeyboardNotification = NotificationCenter.default.publisher(for: closeKeyboardNotification)

struct RootModuleNavStackView: View {
    @Binding var showSideNav: Bool
    var rootModule: RootModule
    @State var path = NavigationPath()
    @State var keyboardIsOpen = false
    @State var delayedSideNavOpening = false
    
    var body: some View {
        NavigationStack(path: $path) {
            RootModuleView(rootModule: rootModule, path: $path)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            // If side nav is about to be opened and the keyboard is currently open
                            // Dismiss the keyoard and delay the side nav opening (see .onReceive below)
                            if !showSideNav && keyboardIsOpen { // If I'm about to open the side nav and the keyboard is open
                                NotificationCenter.default.post(name: closeKeyboardNotification, object: nil)
                                delayedSideNavOpening = true
                            } else {
                                showSideNav.toggle()
                            }
                        } label: {
                            Image("hamburger")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 32)
                                .foregroundColor(.yellow)
                                .font(.title)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
//                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
//                    keyboardIsOpen = newIsKeyboardVisible
//                    if !keyboardIsOpen && delayedSideNavOpening {
//                        delayedSideNavOpening = false
//                        showSideNav.toggle()
//                    }
//                }
        }
    }
}

private extension RootModule {
    
    func helpURL() -> URL {
        switch self {
        case .houses:
            return URL(string: "https://google.com")!
        default:
            return URL(string: "https://google.com")!
        }
    }
}
