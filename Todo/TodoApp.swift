//
//  TodoApp.swift
//  Todo
//
//  Created by Thiago Castro on 05/03/26.
//


import SwiftUI

@main
struct TodoApp: App {
    
    let provider = CoreDataProvider()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(\.managedObjectContext, provider.viewContext)
            }
        }
    }
}
