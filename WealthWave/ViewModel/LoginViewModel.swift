//
//  LoginViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 23/09/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var statusCode: Int = 0
    
    var loginSuccessCallback: (() -> Void)?

    func saveLogin(email: String, password: String) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/user/login") else {
            return
        }
        

        let requestData: [String: Any] = [
            "email": email,
            "password": password,
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
                                self.loginSuccessCallback?()
                            }
                        } else if httpResponse.statusCode == 400 {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let message = json["message"] as? String {
                                self.responseMessage = message
                               
                                self.loginSuccessCallback?()
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
