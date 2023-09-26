//
//  GetBudgetViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 26/09/2023.
//

import Foundation
import SwiftUI

class GetBudgetViewModel: ObservableObject {
    @Published var budget: [BudgetItem] = []
    @Published var userId: Int = UserModel.shared.getUserId()

    @Published var isLoading = true

    init() {
        fetchBudgetList()
    }

    func fetchBudgetList() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/budget/get-by-user?userId=\(userId)") else {
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
                    let response = try JSONDecoder().decode(BudgetResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.budget = response.details
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

