//
//  BudgetCategoryModel.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import Foundation

struct BudgetCategory: Codable {
    let budgetCategoryName: String
    let budgetCategoryId: Int
}

struct BudgetCategoryResponse: Codable {
    let message: String
    let details: [BudgetCategory]
    let status: String
    let timestamp: String
}



