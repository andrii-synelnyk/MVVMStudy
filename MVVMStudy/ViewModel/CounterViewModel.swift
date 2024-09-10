//
//  CounterViewModel.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 07.09.2024.
//
import Foundation
import SwiftData

class CounterViewModel: ObservableObject {
    @Published var numberStorage: NumberStorage
    @Published var savedNumbers: [NumberStorage] = []
    
    private var modelContext: ModelContext
    
    init(numberStorage: NumberStorage, modelContext: ModelContext) {
        self.numberStorage = numberStorage
        self.modelContext = modelContext
        fetchSavedNumbers()
    }
    
    func increaseCounter() {
        numberStorage.number += 1
    }
    
    func decreaseCounter() {
        numberStorage.number -= 1
    }
    
    func fetchSavedNumbers() {
        let fetchDescriptor = FetchDescriptor<NumberStorage>()
        
        do {
            savedNumbers = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching saved numbers: \(error)")
        }
    }
    
    func saveCurrentNumber() {
        let numberStorageCopy: NumberStorage = NumberStorage(number: numberStorage.number)
        modelContext.insert(numberStorageCopy)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save number: \(error)")
        }
        
        fetchSavedNumbers()
    }
    
    func deleteSavedNumber(at offsets: IndexSet) {
        offsets.forEach { index in
            let numberStorage = savedNumbers[index]
            modelContext.delete(numberStorage)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save after deleting: \(error)")
        }
        
        fetchSavedNumbers()
    }
}
