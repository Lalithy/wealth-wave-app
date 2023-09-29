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
    
    @State private var isDownloading = false
    
    @State private var isReportVisible = false
    @State private var budgetCategoryId = ""
    @State private var selectedMonth: String = ""
    
    @State private var showAlert = false
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Expenses Details Report")
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
                    .frame(width: 200, height: 35)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(5)
                    .foregroundColor(Color.black)
                }
                
                VStack {
                    Button(action: {
                        if let monthNumber = reportViewModel.getMonthNumber(from: selectedMonth) {
                            reportViewModel.fetchReportData(month: monthNumber)
                            showAlert  = false
                            reportViewModel.recordNotFoundCallback = {
                                showAlert  = true
                                reportViewModel.reportData = []
                            }
                            
                        }
                    }) {
                        Image(systemName: "magnifyingglass.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                            .frame(width: 50, height: 35)
                            .bold()
                            .background(.white)
                            .cornerRadius(5)
                            .shadow(radius: 2)
                    }
                    .background(Color.clear)
                }
            }
            
            HStack{
                
                if showAlert {
                    Text("Records not found for the given month.")
                        .foregroundColor(.red)
                }
                
            }
            
            
            HStack {
                VStack {
                    Text("Date")
                        .font(.headline)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    Text("Category")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    Text("Description")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    Text("Amount")
                        .font(.headline)
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.top, 10)
            
            Rectangle()
                .frame(height: 1)
                .padding(.leading,20)
                .padding(.trailing,20)
                .foregroundColor(.blue)
            
            ScrollView {
                ForEach(reportViewModel.reportData, id: \.expenseId) { item in
                    ReportListView(expenseDate: item.expenseDate, expenseCategory: item.expenseCategory ,expenseDetails: item.expenseDetails, expenseAmount: item.expenseAmount)
                }
            }
            
            Spacer()
            
//            Button(action: {
//
//            }) {
//                Image(systemName: "arrow.down.circle")
//                    .font(.system(size: 40))
//                    .foregroundColor(.blue)
//            }
//            .padding(.bottom, 20)
//            .padding(.trailing, 20)
        }
        .onAppear {
            if let monthNumber = reportViewModel.getMonthNumber(from: selectedMonth) {
                
                reportViewModel.fetchReportData(month: monthNumber)
            }
        }
        //                                        .alert(isPresented: $showAlert) {
        //
        //
        //                                            Alert(
        //                                                title: Text("Record not found"),
        //                                                message: Text("The requested records could not be found."),
        //                                                dismissButton: .default(Text("OK")) {
        //
        //                                                    //reportViewModel.reportData = []
        //
        //                                                }
        //
        //                                            )
        //                                        }
        
    }
}

struct ReportListView: View {
    
    var expenseDate: String
    var expenseCategory: String
    var expenseDetails: String
    var expenseAmount: Double
    
    var body: some View {
        
        
        HStack {
            VStack {
                Text(expenseDate)
                    .font(.system(size: 13))
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Text(expenseCategory)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            VStack {
                Text(expenseDetails)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Text(String(format: "%.2f", expenseAmount))
                    .font(.system(size: 15))
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.top, 10)
        
        Rectangle()
            .frame(height: 1)
            .padding(.leading,20)
            .padding(.trailing,20)
            .foregroundColor(.blue)
    
        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

