//
//  DeleteIncomeViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 29/09/2023.
//

import Foundation

class DeleteIncomeViewModel: ObservableObject {
    @Published var isDeleting = false
    @Published var deleteError: Error?
    @Published var incomeDeleted = false
    @Published var incomeDeleteResponse: IncomeDeleteModel?

    func deleteIncome(incomeId: Int, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/income/remove?incomeId=\(incomeId)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.isDeleting = true
        self.deleteError = nil
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isDeleting = false
                
                if let error = error {
                    self.deleteError = error
                    completion(false, "Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                 
                    if let data = data {
                        do {
                            let errorResponse = try JSONDecoder().decode(IncomeDeleteModel.self, from: data)
                            self.incomeDeleteResponse = errorResponse
                            completion(false, errorResponse.message)
                        } catch {
                            self.deleteError = error
                            completion(false, "Delete request failed.")
                        }
                    } else {
                        self.deleteError = NSError(domain: "DeleteErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Delete request failed."])
                        completion(false, "Delete request failed.")
                    }
                    return
                }

                completion(true, "Successfully Deleted!")
            }
        }.resume()
    }
}
