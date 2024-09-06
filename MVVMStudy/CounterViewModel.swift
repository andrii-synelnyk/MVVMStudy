//
//  CounterViewModel.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 07.09.2024.
//
import Foundation

class CounterViewModel: ObservableObject {
    @Published var numberStorage: NumberStorage
    
    init(numberStorage: NumberStorage) {
        self.numberStorage = numberStorage
    }
    
    func increaseCounter() {
        numberStorage.counter += 1
    }
    
    func decreaseCounter() {
        numberStorage.counter -= 1
    }
}
