//
//  ContentView.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 06.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CounterViewModel(numberStorage: NumberStorage(counter: 0))
    
    var body: some View {
        CounterView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
