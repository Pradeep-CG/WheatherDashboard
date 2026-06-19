//
//  WheatherDashboardApp.swift
//  WheatherDashboard
//
//  Created by Pradeep Kumar Sagar on 10/06/26.
//

import SwiftUI
import CoreData

@main
struct WheatherDashboardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FirstView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
