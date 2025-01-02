//
//  NoteTakingApp_SwiftUiCoreDataApp.swift
//  NoteTakingApp_SwiftUiCoreData
//
//  Created by 5. 3 on 29/07/2024.
//

import SwiftUI

@main
struct NoteTakingApp_SwiftUiCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
