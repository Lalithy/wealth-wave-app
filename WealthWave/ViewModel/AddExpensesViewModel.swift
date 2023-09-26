//
//  AddExpensesViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import Foundation
 

class AddExpensesViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var statusCode: Int = 0
    
    var expensesSuccessCallback: (() -> Void)?

    func saveExpense(expenseDetails: String, expenseAmount: Double, expenseDate: Date, location: String, budgetCategoryId: Int, userId: Int) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/expense/add") else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let expenseDateStr = dateFormatter.string(from: expenseDate)

        let requestData: [String: Any] = [
            "expenseDetails": expenseDetails,
            "expenseAmount": expenseAmount,
            "expenseDate": expenseDateStr,
            "location": location,
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
                                //print("Expenses code: \(self.statusCode)")
                                
                                self.expensesSuccessCallback?()
                            }
                        } else if httpResponse.statusCode == 400 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                self.responseMessage = message
                               // print("Expenses code: \(self.statusCode)")
                                self.expensesSuccessCallback?()
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




  
