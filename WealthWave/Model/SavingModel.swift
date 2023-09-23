//
//  SavingModel.swift
//  WealthWave
//
//  Created by Lali.. on 23/09/2023.
//

import Foundation

struct SavingsResponse: Codable {
    let message: String
    let details: SavingsDetails
    let status: String
    let timestamp: String
}

struct SavingsDetails: Codable {
    let sumOfSavingsAmount: Double
}

