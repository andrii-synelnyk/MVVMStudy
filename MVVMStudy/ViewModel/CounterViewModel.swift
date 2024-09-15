//
//  CounterViewModel.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 07.09.2024.
//
import Foundation
import SwiftData
import SwiftUI

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
        let numberStorageCopy: NumberStorage = NumberStorage(number: numberStorage.number) // copy a value from the current counter to a copy object used for saving
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
    
    func handleItemTapped(_ numberStorage: NumberStorage) {
        self.numberStorage.number = numberStorage.number
    }
    
    func deleteAllItems() {
        do {
            try modelContext.delete(model: NumberStorage.self)
        } catch {
            print("Failed to clear all numbers: \(error)")
        }
        
        fetchSavedNumbers()
    }
    
    func getRandomNumber() async throws -> Int {
        // Random.org API endpoint to get a single integer in the range -100000 to 100000
        let endpoint = "https://www.random.org/integers/?num=1&min=-1000&max=1000&col=1&base=10&format=plain&rnd=new"
        
        guard let url = URL(string: endpoint) else {
            throw APICallError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APICallError.invalidResponse
        }
        
        guard let numberString = String(data: data, encoding: .utf8), let number = Int(numberString.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            throw APICallError.invalidData
        }
        
        return number
    }
    
    func setRandomNumber() {
        Task {
            do {
                let randomNumber = try await getRandomNumber()
                
                self.numberStorage.number = randomNumber
            } catch {
                print("Error fetching number: \(error)")
            }
        }
    }
}
