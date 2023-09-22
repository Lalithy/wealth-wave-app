//
//  ListOfExpensesViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import Foundation
import SwiftUI

class ListOfExpensesViewModel: ObservableObject {
    @Published var budgetCategories: [BudgetCategory] = []

    @Published var isLoading = true

    init() {
        fetchBudgetCategories()
    }

    func fetchBudgetCategories() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/budget/all") else {
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
                    let response = try JSONDecoder().decode(BudgetCategoryResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.budgetCategories = response.details
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
