//
//  NumberStorage.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 06.09.2024.
//
import SwiftData

@Model
class NumberStorage {
    var number: Int
    
    init(number: Int = 0) {
        self.number = number
    }
}
