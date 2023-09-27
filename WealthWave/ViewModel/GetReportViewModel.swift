//
//  GetReportViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import Foundation
import Combine


class GetReportViewModel: ObservableObject {
    @Published var reportData: [ReportDetails] = []
    @Published var userId: Int = PropertyModel.shared.getUserId()
    @Published var selectedMonth: String = ""
    @Published var showRecordNotFoundAlert = false
    @Published var statusCode: Int = 0
    
    var recordNotFoundCallback: (() -> Void)?

    private let monthNameToNumber: [String: Int] = [
        "January": 1,
        "February": 2,
        "March": 3,
        "April": 4,
        "May": 5,
        "June": 6,
        "July": 7,
        "August": 8,
        "September": 9,
        "October": 10,
        "November": 11,
        "December": 12
    ]
    
    func getMonthNumber(from monthName: String) -> Int? {
           return monthNameToNumber[monthName]
       }

    init() {
        fetchReportData(month: 1)
    }

    func fetchReportData(month: Int) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/report/expense-detail?userId=\(userId)&month=\(month)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                
                self.statusCode = httpResponse.statusCode
                
                if httpResponse.statusCode == 302 {
                  
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ReportResponse.self, from: data)
                            DispatchQueue.main.async {
                                self.reportData = response.details
                            }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                } else if httpResponse.statusCode == 404 {
//                    DispatchQueue.main.async {
//                        self.showRecordNotFoundAlert = true
//                    }
                    
                    self.recordNotFoundCallback?()
                }
            }
        }.resume()
    }
}


