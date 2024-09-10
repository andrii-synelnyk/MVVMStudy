//
//  ContentView.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 06.09.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    var body: some View {
        CounterView(modelContext: modelContext)
    }
}

#Preview {
    ContentView()
}
