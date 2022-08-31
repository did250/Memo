//
//  MemoApp.swift
//  Shared
//
//  Created by 양희원 on 2022/08/25.
//

import SwiftUI

@main
struct MemoApp: App {
    
    @StateObject var store = MemoStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Main()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
