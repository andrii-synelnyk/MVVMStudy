//
//  MVVMStudyApp.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 06.09.2024.
//

import SwiftUI
import SwiftData

@main
struct MVVMStudyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [NumberStorage.self]) // array initalizer is not for an array of NumberStorage objects, but just for future addition of other models
    }
}
