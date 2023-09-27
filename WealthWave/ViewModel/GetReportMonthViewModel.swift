//
//  GetReportMonthViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import Foundation

class GetReportMonthViewModel: ObservableObject {
    @Published var reportDates: [String] = []
    @Published var selectedMonth: String = "" 

    @Published var isLoading = true

    init() {
        fetchReportDates()
    }

    func fetchReportDates() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/report/months") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(ReportMonthResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.reportDates = response.details ?? []
                        if let firstMonth = self.reportDates.first {
                            self.selectedMonth = firstMonth // Set the selected month to the first month in the list
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
