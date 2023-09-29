//
//  ChartsViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 30/09/2023.
//

import Foundation
import Foundation

class ChartsViewModel: ObservableObject {
    
    @Published var chartExpenses: [ChartExpensesDetails] = []
    @Published var userId: Int = PropertyModel.shared.getUserId()

    @Published var isLoading = true

    init() {
        fetchChartExpensesList()
    }

    func fetchChartExpensesList() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/dashboard/expenses-statistics?userId=\(userId)") else {
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
                    let response = try JSONDecoder().decode(ChartExpensesResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.chartExpenses = response.details
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}



