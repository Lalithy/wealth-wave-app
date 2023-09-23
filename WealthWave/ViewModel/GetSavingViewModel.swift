//
//  GetSavingViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 23/09/2023.
//

import Foundation
import Combine


class GetSavingViewModel: ObservableObject {
    @Published var sumOfSavingsAmount: Double = 0.0
    @Published var userId: Int = 0
    
    init() {
           
           fetchSavingsData()
       }

    func fetchSavingsData() {
        
        print("Fetching data for userId: \(userId)")
        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/savings/get-by-user?userId=\(userId)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SavingsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                self.sumOfSavingsAmount = response.details.sumOfSavingsAmount
            })
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []
}


//class GetSavingViewModel: ObservableObject {
//    @Published var sumOfSavingsAmount: Double = 0.0
//    @Published var userId: Int = 0
//
//
//    init() {
//        fetchSavingsData()
//    }
//
//    func fetchSavingsData() {
//
//        print("Fetching data for userId: \(userId)")
//
//        guard let url = URL(string: "http://wealth-wave-service-env.eba-cc4bdc5e.us-west-1.elasticbeanstalk.com/api/fhms/savings/get-by-user?userId=\(userId)") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: SavingsResponse.self, decoder: JSONDecoder())
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("Network error: \(error.localizedDescription)")
//                }
//            }, receiveValue: { response in
//                self.sumOfSavingsAmount = response.details.sumOfSavingsAmount
//            })
//            .store(in: &cancellables)
//    }
//
//    private var cancellables: Set<AnyCancellable> = []
//}
