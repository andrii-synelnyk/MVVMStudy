//
//  CounterView.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 07.09.2024.
//

import SwiftUI

struct CounterView: View {
    @ObservedObject var viewModel: CounterViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.decreaseCounter()
            }, label: {
                Text("-")
                    .font(.system(size: 100))
            })
            
            Text("\(viewModel.numberStorage.counter)")
                .font(.system(size: 100))

            Button(action: {
                viewModel.increaseCounter()
            }, label: {
                Text("+")
                    .font(.system(size: 100))
            })
        }
    }
}

#Preview {
    CounterView(viewModel: CounterViewModel(numberStorage: NumberStorage(counter: 0)))
}
