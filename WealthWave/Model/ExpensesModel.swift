//
//  ExpensesModel.swift
//  WealthWave
//
//  Created by Lali.. on 24/09/2023.
//

import Foundation

struct ExpensesDetails: Codable {
    let expenseId: Int
    let expenseDetails: String
    let expenseAmount: Double
    let expenseDate: String
    let expenseCategory: String
}

struct ExpensesResponse: Codable {
    let message: String
    let details: [ExpensesDetails]
    let status: String
    let timestamp: String
}


