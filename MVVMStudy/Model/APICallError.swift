//
//  APICallError.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 15.09.2024.
//

import Foundation

enum APICallError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
