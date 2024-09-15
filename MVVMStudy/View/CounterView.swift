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
            
            ZStack {
                HStack {
                    Button(action: {
                        viewModel.decreaseCounter()
                    }, label: {
                        Image(systemName: "minus.circle")
                                .font(.system(size: 35))
                    })
                    
                    Text("\(viewModel.numberStorage.number)") // \(viewModel.numberStorage.number)
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
                .frame(width: 250)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        viewModel.increaseCounter()
                    }, label: {
                        Image(systemName: "dice")
                                .font(.system(size: 35))
                    })
                }.padding()
            }.frame(height: 120)
            
            Spacer().frame(height: 20)
            
            Button(action: {
                viewModel.saveCurrentNumber()
            }, label: {
                Text("Save number")
            })
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 20)
            
            List {
                if !viewModel.savedNumbers.isEmpty {
                    Section(header: HStack {
                        Spacer()
                        Button("Clear All") {
                            viewModel.deleteAllItems()
                        }
                        .padding(.trailing, -18)
                    }.padding(.bottom, 12)) {
                        ForEach(viewModel.savedNumbers) { numberStorage in
                            NumberRowView(numberStorage: numberStorage) {
                                viewModel.handleItemTapped(numberStorage)
                            }
                        }
                        .onDelete(perform: viewModel.deleteSavedNumber)
                    }
                } else {
                    Text("No numbers saved")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
    }
}


