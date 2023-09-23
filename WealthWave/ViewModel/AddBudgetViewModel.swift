//
//  AddBudgetViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 23/09/2023.
//

import Foundation


class AddBudgetViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var statusCode: Int = 0
    
    var budgetSuccessCallback: (() -> Void)?

    func saveBudget(budgetAmount: Double, budgetCategoryId: Int, userId: Int) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/budget/add") else {
            return
        }
        

        let requestData: [String: Any] = [
            "budgetAmount": budgetAmount,
            "budgetCategoryId": budgetCategoryId,
            "userId": userId
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    self.statusCode = 500
                    self.responseMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                if let data = data {
                    if let httpResponse = response as? HTTPURLResponse {
                        
                        self.statusCode = httpResponse.statusCode
                        
                        if httpResponse.statusCode == 200 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                self.responseMessage = message
                                self.budgetSuccessCallback?()
                            }
                        } else if httpResponse.statusCode == 400 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                self.responseMessage = message
                               
                                self.budgetSuccessCallback?()
                            }
                        }
                    }
                }
            }.resume()
        } catch {
            print("Error creating JSON data: \(error)")
            self.responseMessage = "Error: \(error.localizedDescription)"
        }
    }
}
