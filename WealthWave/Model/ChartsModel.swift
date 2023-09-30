//
//  ChartsModel.swift
//  WealthWave
//
//  Created by Lali.. on 30/09/2023.
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

struct ChartExpensesCategory: Codable {
    let budgetCategory: String
    let expensePercentage: Double
}

struct ChartExpensesCategoryResponse: Decodable {
    let message: String
    let details: [ChartExpensesCategory]
    let status: String
    let timestamp: String
}

struct ChartStatisticsResponse: Codable {
    let message: String
    let details: [ChartStatisticsDetail]
    let status, timestamp: String
}

struct ChartStatisticsDetail: Codable {
    let month: String
    let statistics: [Statistic]
}

struct Statistic: Codable {
    let name: String
    let totalValue: Double
}

