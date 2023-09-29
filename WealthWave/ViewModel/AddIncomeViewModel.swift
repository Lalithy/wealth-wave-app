//
//  AddIncomeViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 23/09/2023.
//

import Foundation

class AddIncomeViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var statusCode: Int = 0
    
    var incomeSuccessCallback: (() -> Void)?

    func saveIncome(incomeDetails: String, incomeAmount: Double, incomeDate: Date, userId: Int) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/income/add") else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let incomeDateStr = dateFormatter.string(from: incomeDate)

        let requestData: [String: Any] = [
            "incomeDetails": incomeDetails,
            "incomeAmount": incomeAmount,
            "incomeDate": incomeDateStr,
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
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.statusCode = httpResponse.statusCode
                        }
                        
                        
                        if httpResponse.statusCode == 200 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                
                                DispatchQueue.main.async { [weak self] in
                                    self?.responseMessage = message
                                    self?.incomeSuccessCallback?()
                                }
                                
                            }
                        } else if httpResponse.statusCode == 400 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                
                                DispatchQueue.main.async { [weak self] in
                                    self?.responseMessage = message
                                    self?.incomeSuccessCallback?()
                                }
                                
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
