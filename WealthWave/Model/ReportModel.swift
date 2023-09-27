//
//  ReportModel.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import Foundation


struct ReportDetails: Codable {
    let expenseId: Int
    let expenseDate: String
    let expenseDetails: String
    let expenseAmount: Double
    let expenseCategory: String
}


struct ReportResponse: Decodable {
    let message: String
    let details: [ReportDetails]
    let status: String
    let timestamp: String
}


