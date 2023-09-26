//
//  BudgetModel.swift
//  WealthWave
//
//  Created by Lali.. on 26/09/2023.
//

import Foundation


struct BudgetItem: Codable {
    let budgetCategoryId: Int
    let budgetCategoryName: String
    let estimatedBudget: Double
    let remainingBudget: Double
    let expense: Double
}


struct BudgetResponse: Decodable {
    let message: String
    let details: [BudgetItem]
    let status: String
    let timestamp: String
}




