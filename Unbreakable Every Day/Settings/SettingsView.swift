//
//  SettingsView.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var theme: ThemeManager
    var viewModel = SettingsViewModel()
    var body: some View {
        List {
            Toggle("Dark Mode",isOn: theme.$isDarkMode)
                
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
