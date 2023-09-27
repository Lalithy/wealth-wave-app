//
//  ReportDateModel.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import Foundation

struct ReportDateResponse: Codable {
    let message: String
    let details: String?
    let status: String
    let timestamp: String
}


//{
//    "message": "Found Months!",
//    "details": [
//        "January",
//        "February",
//        "March",
//        "April",
//        "May",
//        "June",
//        "July",
//        "August",
//        "September"
//    ],
//    "status": "FOUND",
//    "timestamp": "2023-09-27T09:31:47.331696997"
//}
