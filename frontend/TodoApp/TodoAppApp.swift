//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/1/22.
//

import SwiftUI

@main
struct TodoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TaskViewModel())
        }
    }
}
