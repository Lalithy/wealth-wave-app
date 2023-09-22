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
                    
                Text("Category")
                    .font(.headline)
                   
                Text("Description")
                    .font(.headline)
                    
                Text("Amount")
                    .font(.headline)
                    
            }.padding(.leading, 10)
            .padding(.top, 10)

            ScrollView {
                LazyVStack {
                    ForEach(incomeData) { item in

                        VStack{
                            HStack {
                        
                                Text(item.date, style: .date)
                                    
                                Text(item.category)
                                    
                                Text(item.description)
                                   
                                Text(String(format: "%.2f", item.amount))
                                    
                            }
                        }
                        
                    }
                }
            }
            //.frame(maxHeight: 700)
            
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