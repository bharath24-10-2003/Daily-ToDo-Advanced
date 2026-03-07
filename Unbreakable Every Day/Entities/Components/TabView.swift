//
//  TabView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI

struct CustomTabView: View {
    
    @EnvironmentObject var theme: ThemeManager
    var body: some View {
        TabView {
            Tab {
                DashView()
            } label: {
                CustomTabLabelView(logo: "house", desc: "Dash Board")
            }
            Tab {
                ManageView()
            } label: {
               CustomTabLabelView(logo: "person.crop.rectangle.stack", desc: "Manage")
            }
            Tab {
                SettingsView()
            } label: {
                CustomTabLabelView(logo: "gearshape.2.fill", desc: "Settings")
            }
        }
        .colorScheme(theme.isDarkMode ? .dark : .light)
    }
}

struct CustomTabLabelView: View {
    @State var logo: String
    @State var desc: String
    var body: some View {
        VStack{
            Image(systemName: logo)
            Text(desc)
        }
    }
}

#Preview {
    CustomTabView()
}
