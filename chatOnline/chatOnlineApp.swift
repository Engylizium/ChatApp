//
//  chatOnlineApp.swift
//  chatOnline
//
//  Created by Соболев Пересвет on 6/6/23.
//

import SwiftUI

@main
struct chatOnlineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
