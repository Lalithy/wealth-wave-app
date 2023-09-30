//
//  ChartStatisticsViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 2023-09-30.
//


import Foundation
import SwiftUI


class ChartStatisticsViewModel: ObservableObject {
    
    @Published var chartStatistics: [ChartStatisticsDetail] = []
    @Published var userId: Int = PropertyModel.shared.getUserId()

    @Published var isLoading = true

    init() {
        fetchChartStatisticsList()
    }

    func fetchChartStatisticsList() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/dashboard/statistics?userId=\(userId)") else {
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
                    let response = try JSONDecoder().decode(ChartStatisticsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.chartStatistics = response.details
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
