//
//  AppNotesApp.swift
//  AppNotes
//
//  Created by Juan Cruz on 12/07/2022.
//

import SwiftUI

@main
struct AppNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
