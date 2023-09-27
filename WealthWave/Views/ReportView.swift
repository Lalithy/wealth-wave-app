//
//  ReportView.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import SwiftUI


struct ReportView: View {
    @StateObject var reportMonthVM : GetReportMonthViewModel = GetReportMonthViewModel()
    @StateObject var reportViewModel: GetReportViewModel = GetReportViewModel()
    
    @State private var isReportVisible = false
    @State private var budgetCategoryId = ""
    @State private var selectedMonth: String = ""
    
    @State private var showAlert = false
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Detail Report")
                    .font(.system(size: 25))
                    .bold()
                Spacer()
            }
            
            HStack{
                VStack {
                    Picker("Months", selection: $selectedMonth) {
                        ForEach(reportMonthVM.reportDates, id: \.self) { month in
                            Text(month)
                        }
                    }
                    .padding()
                    .frame(height: 50)
                    .clipped()
                    .frame(width: 200)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    
                    .foregroundColor(Color.black)
                }
                
                VStack {
                    Button(action: {
                        if let monthNumber = reportViewModel.getMonthNumber(from: selectedMonth) {
                            
                            reportViewModel.fetchReportData(month: monthNumber)
                            
                            reportViewModel.recordNotFoundCallback = {
                                
                                showAlert  = true
                                reportViewModel.reportData = []
                            }
                            
                        }
                    }) {
                        Text("Search")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .bold()
                            .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                    }
                    .background(Color.clear)
                }
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
                ForEach(reportViewModel.reportData, id: \.expenseId) { item in
                    ReportListView(expenseDate: item.expenseDate, expenseCategory: item.expenseCategory ,expenseDetails: item.expenseDetails, expenseAmount: item.expenseAmount)
                }
            }
            
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
        .onAppear {
            if let monthNumber = reportViewModel.getMonthNumber(from: selectedMonth) {
                
                reportViewModel.fetchReportData(month: monthNumber)
            }
        }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Record not found"),
                        message: Text("The requested records could not be found."),
                        dismissButton: .default(Text("OK")) {
        
                            //reportViewModel.reportData = []
                            
                        }
                    )
                }
    }
}

struct ReportListView: View {
    
    var expenseDate: String
    var expenseCategory: String
    var expenseDetails: String
    var expenseAmount: Double
    
    var body: some View {
        
        VStack {
            HStack {
                
                //.padding(.leading, 10)
                
                Text(expenseDate)
                    .font(.system(size: 15))
                
                Text(expenseCategory)
                    .font(.system(size: 15))
                
                Text(expenseDetails)
                    .font(.system(size: 15))
                
                Text(String(format: "%.2f", expenseAmount))
                    .font(.system(size: 15))
                //.padding(.leading, 10)
                //Spacer()
                
            }
            //Spacer()
            
            
        }
        .padding(.top, 10)
        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

