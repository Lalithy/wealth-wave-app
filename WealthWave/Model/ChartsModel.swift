//
//  ChartsModel.swift
//  WealthWave
//
//  Created by Lali.. on 2023-09-29.
//


import Foundation


struct ChartExpensesDetails: Codable {
    let month: String
    let expenseTotal: Double
}

struct ChartExpensesResponse: Decodable {
    let message: String
    let details: [ChartExpensesDetails]
    let status: String
    let timestamp: String
}

