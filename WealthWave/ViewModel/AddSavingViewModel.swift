//
//  AddSavingViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 23/09/2023.
//


import Foundation

class AddSavingViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var statusCode: Int = 0
    
    var saveSuccessCallback: (() -> Void)?

    func saveSaving(savingsDetails: String, savingsAmount: Double, savingsDate: Date, userId: Int) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/savings/add") else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let savingDateStr = dateFormatter.string(from: savingsDate)

        let requestData: [String: Any] = [
            "savingsDetails": savingsDetails,
            "savingsAmount": savingsAmount,
            "savingsDate": savingDateStr,
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
                    print("Error saving 1: \(error)")
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
                                    self?.saveSuccessCallback?()
                                }
                                
                            }
                        } else if httpResponse.statusCode == 400 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                
                                DispatchQueue.main.async { [weak self] in
                                    self?.responseMessage = message
                                    self?.saveSuccessCallback?()
                                }
                                
                            }
                        }
                    }
                }
            }.resume()
        } catch {
            print("Error creating JSON data: \(error)")
            self.responseMessage = "Error saving 3: \(error.localizedDescription)"
        }
    }
}
