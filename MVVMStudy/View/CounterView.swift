//
//  CounterView.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 07.09.2024.
//

import SwiftUI
import SwiftData

struct CounterView: View {
    @StateObject private var viewModel: CounterViewModel
   
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: CounterViewModel(numberStorage: NumberStorage(number: 0), modelContext: modelContext))
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.decreaseCounter()
                }, label: {
                    Text("-")
                        .font(.system(size: 100))
                })
                
                Text("\(viewModel.numberStorage.number)")
                    .font(.system(size: 100))
                
                Button(action: {
                    viewModel.increaseCounter()
                }, label: {
                    Text("+")
                        .font(.system(size: 100))
                })
            }
            
            Button(action: {
                viewModel.saveCurrentNumber()
            }, label: {
                Text("Save value")
            })
            .buttonStyle(.borderedProminent)
            
            List {
                ForEach(viewModel.savedNumbers) { numberStorage in
                    Text("\(numberStorage.number)")
                }
                .onDelete(perform: viewModel.deleteSavedNumber)
            }
        }
    }
}


