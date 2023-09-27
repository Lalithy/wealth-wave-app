//
//  ReportMonthModel.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import Foundation

struct ReportMonthResponse: Codable {
    let message: String
    let details: [String]? 
    let status: String
    let timestamp: String
}

