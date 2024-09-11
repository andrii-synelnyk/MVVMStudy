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
    @State private var showAlert = false
   
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: CounterViewModel(numberStorage: NumberStorage(number: 0), modelContext: modelContext))
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.decreaseCounter()
                }, label: {
                    Image(systemName: "minus.circle")
                            .font(.system(size: 35))
                })
                
                Text("\(viewModel.numberStorage.number)")
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.3)
                    .lineLimit(1)
                    .padding([.leading, .trailing], 10)
                
                Button(action: {
                    viewModel.increaseCounter()
                }, label: {
                    Image(systemName: "plus.circle")
                            .font(.system(size: 35))
                })
            }
            
            Spacer().frame(height: 20)
            
            Button(action: {
                viewModel.saveCurrentNumber()
            }, label: {
                Text("Save value")
            })
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 20)
            
            List {
                ForEach(viewModel.savedNumbers) { numberStorage in
                    NumberRowView(numberStorage: numberStorage) {
                        viewModel.handleItemTapped(numberStorage)
                    }
                }
                .onDelete(perform: viewModel.deleteSavedNumber)
            }
        }
        .padding()
    }
}


