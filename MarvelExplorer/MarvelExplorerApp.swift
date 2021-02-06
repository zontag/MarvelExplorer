//
//  MarvelExplorerApp.swift
//  MarvelExplorer
//
//  Created by Tiago Zontag on 06/02/21.
//

import SwiftUI

@main
struct MarvelExplorerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
