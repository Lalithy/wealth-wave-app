//
//  ReportView.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import SwiftUI

struct ReportView: View {
    
    @State private var isReportVisible = false

    let incomeData: [ReportItem] = [
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
        ReportItem(date: Date(), category: "Food", description: "Salary", amount: 1000.0 ),
    ]

    
    var body: some View {
        
        
        VStack {
            HStack {
                Spacer()
                Text("Detail Report")
                    .font(.system(size: 25))
                    .bold()
                Spacer()
            }

            HStack {
                Text("Date")
                    .font(.headline)
                    .padding(.trailing, 30)
                Text("Category")
                    .font(.headline)
                    .padding(.trailing, 30)
                Text("Description")
                    .font(.headline)
                    .padding(.trailing, 30)
                Text("Amount")
                    .font(.headline)
                    
            }
            .padding(.top, 10)

            ScrollView {
                LazyVStack {
                    ForEach(incomeData) { item in

                        VStack{
                            HStack {
                        
                                Text(item.date, style: .date)
                                    .padding(.trailing, 30)
                                Text(item.category)
                                    .padding(.trailing, 30)
                                Text(item.description)
                                    .padding(.trailing, 30)
                                Text(String(format: "%.2f", item.amount))
                                    .padding(.leading, 10)
                            }
                        }
                        
                    }
                }
            }
            .frame(maxHeight: 700)
            
            
            Spacer()
            
    
            
            Button(action: {
                
            }) {
                Image(systemName: "arrow.down.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

struct ReportItem: Identifiable {
    let id = UUID()
    let date: Date
    let category: String
    let description: String
    let amount: Double
}
