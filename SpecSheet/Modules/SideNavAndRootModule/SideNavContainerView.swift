//
//  SideNavView.swift
//  Excalibur
//
//  Created by Kraig Wastlund on 1/18/23.
//

import SwiftUI

struct SideNavContainerView: View {

    @Binding var showSideNav: Bool
    let rootModule: RootModule
    let selected: (_ itemSelected: RootModule) -> Void

    @State var animateShowDimmedView = false

    var body: some View {
        HStack(spacing: 0) {
            SideNavView(rootModule: rootModule, selected: selected)
                .frame(width: 250)

            DimmedView(animateShowDimmedView: $animateShowDimmedView)
                .onTapGesture {
                    if showSideNav == true {
                        showSideNav.toggle()
                    }
                }
                .onChange(of: showSideNav) { visible in
                    if visible {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            animateShowDimmedView = true
                        }
                    } else {
                        animateShowDimmedView = false
                    }
                }
        }
    }
}

private enum SideNavSheetType {
    case settings
    case account
    case help
}

private struct SideNavView: View {

    let rootModule: RootModule
    let selected: (_ itemSelected: RootModule) -> Void
    @State var showHelp = false
    @State var showSettings = false
    @State var showAccount = false

    var body: some View {
        ZStack {
            Color.charcoal
                .ignoresSafeArea()
            VStack(spacing: 0) {
                SideNavLogoAndTitleView()
                SideNavMenuView(selected: selected, currentSelection: rootModule)
                Spacer()
                SideNavFooterView { type in
                    switch type {
                    case .settings:
                        showSettings = true
                    case .account:
                        showAccount = true
                    case .help:
                        showHelp = true
                    }
                }
                Text("1.0.0")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

private struct SideNavLogoAndTitleView: View {
    
    var body: some View {
        VStack {
            Text("Spec Sheet")
                .font(.title)
                .foregroundColor(.yellow)
            Divider()
                .frame(height: 1)
                .background(.yellow)
        }
    }
}

private struct SideNavFooterView: View {

    let showSheet: (_ sheetType: SideNavSheetType) -> Void

    var body: some View {
        SideNavFooterSelectableRowView(title: "Help", iconName: "questionmark.circle") {
            showSheet(.help)
        }
        SideNavFooterSelectableRowView(title: "Settings", iconName: "gear") {
            showSheet(.settings)
        }
        SideNavUserInfoSelectableRowView(title: "Bob Marley") {
            showSheet(.account)
        }
    }
}

private struct SideNavMenuView: View {
    let selected: (_ itemSelected: RootModule) -> Void
    @State var currentSelection: RootModule

    var body: some View {
        ScrollView {
            SideNavMenuSelectableRowView(title: RootModule.houses.title, isSelected: currentSelection == .houses, iconName: nil) {
                selected(.houses)
                currentSelection = .houses
            }
            
            SideNavMenuSelectableRowView(title: RootModule.archived.title, isSelected: currentSelection == .archived, iconName: nil) {
                selected(.archived)
                currentSelection = .archived
            }
            
            SideNavMenuSelectableRowView(title: RootModule.placeholder1.title, isSelected: currentSelection == .placeholder1, iconName: nil) {
                selected(.placeholder1)
                currentSelection = .placeholder1
            }
            
            SideNavMenuSelectableRowView(title: RootModule.placeholder2.title, isSelected: currentSelection == .placeholder2, iconName: nil) {
                selected(.placeholder2)
                currentSelection = .placeholder2
            }
        }
    }
}

private struct DimmedView: View {
    @Binding var animateShowDimmedView: Bool

    var body: some View {
        Rectangle()
            .fill(.clear)
            .edgesIgnoringSafeArea(.all)
            .background(Color.charcoal.opacity(animateShowDimmedView ? 0.5 : 0.0))
            .animation(.easeInOut(duration: animateShowDimmedView ? 0.25 : 0.0), value: animateShowDimmedView)
    }
}

private struct SideNavMenuSelectableRowView: View {
    let title: String
    let isSelected: Bool
    let iconName: String?
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            RowContentView(title: title, isSelected: isSelected, iconName: iconName)
        }
        .buttonStyle(SideNavMenuButtonStyle())
        .edgesIgnoringSafeArea(.all)
    }

    struct RowContentView: View {
        let title: String
        let isSelected: Bool
        let iconName: String?

        var body: some View {
            HStack(spacing: 8) {
                if let iconName = iconName {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 8)
                }
                Text(title)
                    .padding(.leading, iconName != nil ? 0 : 40)
                Spacer()
            }
            .padding()
            .foregroundColor(isSelected ? .lightYellow : .darkYellow)
            .background(isSelected ? Color.lightCharcoal : Color.clear)
            .font(.system(size: 14, weight: .bold))
        }
    }
}

private struct SideNavFooterSelectableRowView: View {
    let title: String
    let iconName: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            RowContentView(title: title, iconName: iconName)
        }
        .foregroundColor(.yellow)
        .font(.system(size: 14, weight: .light))
        .buttonStyle(SideNavMenuButtonStyle())
        .edgesIgnoringSafeArea(.all)
    }

    struct RowContentView: View {
        let title: String
        let iconName: String?

        var body: some View {
            HStack(spacing: 8) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 8)
                }
                Text(title)
                    .padding(.leading, iconName != nil ? 0 : 40)
                Spacer()
            }
            .padding()
        }
    }
}

private struct SideNavUserInfoSelectableRowView: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            RowContentView(title: title)
        }
        .foregroundColor(.blue)
        .font(.system(size: 14))
        .buttonStyle(SideNavMenuButtonStyle())
        .edgesIgnoringSafeArea(.all)
    }

    struct RowContentView: View {
        let title: String

        var body: some View {
            HStack(spacing: 8) {
                Image("test_profile_image") // TODO: Change to user profile image with placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.yellow, lineWidth: 2))
                    .padding(.trailing, 8)
                Text(title)
                    .padding(.leading, 0)
                Spacer()
            }
            .padding()
            .foregroundColor(.yellow)
        }
    }
}

// Button Style

private struct SideNavMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.yellow : .clear)
            .contentShape(Rectangle())
    }
}
