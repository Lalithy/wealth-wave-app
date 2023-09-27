//
//  GetReportDateViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import Foundation

class GetReportDateViewModel: ObservableObject {
//    @Published var reportDate: ReportDateResponse
//
//    @Published var isLoading = true
//
//    init() {
//        fetchReportDate()
//    }
//
//    func fetchReportDate() {
//        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/report/months") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print("Network error: \(error.localizedDescription)")
//                return
//            }
//
//            if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(ReportDateResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self.isLoading = false
//                        self.reportDate = response.details
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }
//        }.resume()
//    }
}
