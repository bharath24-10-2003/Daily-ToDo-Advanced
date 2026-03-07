
//  Unbreakable_Every_DayApp.swift
//  Unbreakable Every Day
//
//  Created by Bharath on 02/03/26.
//

import SwiftUI
import SwiftData

@main
struct Unbreakable_Every_DayApp: App {
    @StateObject private var theme = ThemeManager()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
        }
        .modelContainer(sharedModelContainer)
    }
}
