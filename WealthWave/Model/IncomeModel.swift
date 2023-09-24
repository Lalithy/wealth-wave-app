//
//  IncomeModel.swift
//  WealthWave
//
//  Created by Lali.. on 24/09/2023.
//

import Foundation

struct IncomeItem: Codable {
    let incomeId: Int
    let incomeDate: String
    let incomeDetails: String
    let incomeAmount: Double
}


struct IncomeResponse: Decodable {
    let message: String
    let details: [IncomeItem]
    let status: String
    let timestamp: String
}



