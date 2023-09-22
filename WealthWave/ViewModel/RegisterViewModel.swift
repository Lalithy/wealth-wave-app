
//  RegisterViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import Foundation
import SwiftUI

class RegisterViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    @Published var showSignInView: Bool = false
    
    
   var registrationSuccessCallback: (() -> Void)?
    
    struct RegistrationData: Codable {
        var email: String
        var password: String
        var confirmPassword: String
    }
    
    struct ResponseData: Codable {
        var success: Bool
        var message: String
    }
    struct RegUser: Codable {
        let message: String
        let status: String
    }
    
    enum RegUserError: Error {
        case invalidUrl
    }
    
    func registerUser() {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/user/register") else {
            return
        }
        
        
        let registrationData = RegistrationData(email: email, password: password, confirmPassword: confirmPassword)
        
        guard let jsonData = try? JSONEncoder().encode(registrationData) else {
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                
                if let data = data {
                    
                    if let responseData = try? JSONDecoder().decode(RegUser.self,from: data) {
                        
                        DispatchQueue.main.async {
                            
                
                            if statusCode == 200 {
                                
                                
                                print("Registration: \(responseData.message)")
                              
                                self.registrationSuccessCallback?()
                            } else if statusCode == 400 {
                           
                                
                                print("Registration failed: \(responseData.message)")
                            } else {
                                
                                print("Unexpected status code: \(statusCode)")
                            }
                        }
                    }
                }
            }
        }.resume()
    }
    
}
