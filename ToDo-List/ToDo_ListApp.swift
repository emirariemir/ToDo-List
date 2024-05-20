//
//  ToDo_ListApp.swift
//  ToDo-List
//
//  Created by Emir Arı on 20.05.2024.
//

import SwiftUI
import SwiftData

@main
struct ToDo_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TodoItem.self)
    }
}
