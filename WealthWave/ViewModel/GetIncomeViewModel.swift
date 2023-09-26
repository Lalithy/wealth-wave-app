//
//  GetIncomeViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 24/09/2023.
//

import Foundation
import Combine

class IncomeViewModel: ObservableObject {
    @Published var incomeData: [IncomeItem] = []
    @Published var userId: Int = PropertyModel.shared.getUserId()
    @Published var totalAmount: String = ""
    
    init() {
        fetchIncomeData()
    }
    
    func fetchIncomeData() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/income/get-by-user?userId=\(userId)") else {
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
                    let response = try JSONDecoder().decode(IncomeResponse.self, from: data)
                    DispatchQueue.main.async {
                        
                        self.incomeData = response.details
                        self.totalAmount = response.totalAmount
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
}
