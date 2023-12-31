//
//  AddItemsView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI


struct AddItemsView: View {
    
    init(){
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .headline)], for: .normal)
    }
    
    @State private var selectedSideDashboard: SideOfTheForceDashboard = .expenses
    
    var body: some View {
        
        VStack {
            Picker("Coose a Side", selection: $selectedSideDashboard) {
                ForEach(SideOfTheForceDashboard.allCases, id: \.self) {
                    Text($0.rawValue)
                    
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            ChosenBackgroundViewDashboard(selectedSideDashboard: selectedSideDashboard)
            Spacer()
            
        }
        
    }
}

enum SideOfTheForceDashboard: String, CaseIterable {
    case expenses = "Expenses"
    case income = "Income"
    case savings = "Savings"
}

struct ChosenBackgroundViewDashboard: View {
    
    var selectedSideDashboard: SideOfTheForceDashboard
    
    var body: some View {
        switch selectedSideDashboard {
        case .expenses:
            ExpensesView()
        case .income:
            IncomeView()
        case .savings:
            SavingView()
        }
    }
}



struct TabBarButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isSelected ? .headline : .subheadline)
                .foregroundColor(isSelected ? .mint : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(10)
        }
    }
}

struct AddItemsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddItemsView()
    }
}


struct ExpensesView: View {
    @StateObject var userExpensesList: GetExpensesViewModel = GetExpensesViewModel()
    @State private var isListVisible = false
    @State private var deleteSuccess = false
    @State private var errorMessage = ""
    
    
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(userExpensesList.expenses, id: \.expenseId) { item in
                    UserExpensesListView(
                        iconName: "minus.circle.fill",
                        image: item.expenseCategory,
                        expenseCategory: item.expenseCategory,
                        expenseAmount: item.expenseAmount,
                        expenseDetails: item.expenseDetails,
                        expenseDate: item.expenseDate,
                        expenseId: item.expenseId,
                        onDelete: { success, message in
                            deleteSuccess = success
                            errorMessage = message
                            userExpensesList.fetchExpensesList()
                        }
                    )
                }
            }
            
            Spacer()
            
            NavigationLink(
                destination: ListOfExpensesView(),
                isActive: $isListVisible
            ) {}
            
            Button(action: {
                isListVisible = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
            
            //            if deleteSuccess {
            //                Text("Expense deleted successfully")
            //                    .foregroundColor(.green)
            //                    .padding()
            //            } else if !errorMessage.isEmpty {
            //                Text("Error: \(errorMessage)")
            //                    .foregroundColor(.red)
            //                    .padding()
            //            }
        }
        
        .tag(0)
        .onAppear {
            userExpensesList.fetchExpensesList()
        }
    }
}

struct UserExpensesListView: View {
    @StateObject var deleteExpensesViewModel = DeleteExpensesViewModel()
    
    var iconName: String
    var image: String
    var expenseCategory: String
    var expenseAmount: Double
    var expenseDetails: String
    var expenseDate: String
    var expenseId: Int
    
    var onDelete: (Bool, String) -> Void
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 2)
                .frame(height: 80)
            
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Button(action: {
                        deleteExpense()
                    }) {
                        Image(systemName: iconName)
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .scaledToFit()
                    }
                    .disabled(deleteExpensesViewModel.isDeleting)
                    .padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(image)
                                .resizable()
                                .frame(width: 40, height: 30)
                                .scaledToFit()
                            
                            Text(expenseCategory)
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", expenseAmount))
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Text("LKR")
                                .font(.system(size: 10))
                                .padding(.trailing, 20)
                                .padding(.top, 5)
                        }
                    }
                }
                
                HStack {
                    Text(expenseDetails)
                        .font(.system(size: 15))
                        .padding(.leading, 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text(expenseDate)
                        .font(.system(size: 13))
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(.secondary)
                
            }
            .padding(.top, 10)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
    }
    
    
    private func deleteExpense() {
        deleteExpensesViewModel.deleteExpense(expenseId: expenseId)
        { success, message in
            DispatchQueue.main.async {
                onDelete(success, message)
            }
        }
    }
    
}

struct IncomeView: View {
    
    @StateObject var incomeViewModel: IncomeViewModel = IncomeViewModel()
    @State private var isIncomeVisible = false
    @State private var isListVisible = false
    @State private var deleteSuccess = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            
            Text("Total : \(incomeViewModel.totalAmount)")
                .bold()
                .padding(.top, 10)
                .font(.system(size: 25))
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            
            ScrollView {
                ForEach(incomeViewModel.incomeData, id: \.incomeId) { item in
                    UserIncomeListView(
                        iconName: "minus.circle.fill",
                        image: "dollarsign.arrow.circlepath",
                        incomeDate: item.incomeDate,
                        incomeDetails: item.incomeDetails,
                        incomeAmount: item.incomeAmount,
                        incomeId: item.incomeId,
                        onDeleteIncome: { success, message in
                            deleteSuccess = success
                            errorMessage = message
                        
//                            if incomeViewModel.incomeData.isEmpty{
                                incomeViewModel.fetchIncomeData()
//                            }
                            
                        }
                        
                    )
                }
                
            }
            
            Spacer()
            
            NavigationLink(
                destination: AddIncomeView(),
                isActive: $isListVisible
            ) {
                
            }
            .hidden()
            
            Button(action: {
                isListVisible = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
            
            
        }.tag(1)
            .onAppear {
                incomeViewModel.fetchIncomeData()
            }
    }
}


struct UserIncomeListView: View {
    
    @StateObject var deleteIncomeViewModel = DeleteIncomeViewModel()
    
    var iconName: String
    var image: String
    var incomeDate: String
    var incomeDetails: String
    var incomeAmount: Double
    var incomeId: Int
    
    var onDeleteIncome: (Bool, String) -> Void
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 2)
                .frame(height: 80)
            
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Button(action: {
                        deleteIncome()
                    }) {
                        Image(systemName: iconName)
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .scaledToFit()
                    }
                    .disabled(deleteIncomeViewModel.isDeleting)
                    .padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: image)
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                            
                            
                            Text(incomeDetails)
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", incomeAmount))
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Text("LKR")
                                .font(.system(size: 10))
                                .padding(.trailing, 20)
                                .padding(.top, 5)
                        }
                    }
                }
                
                HStack {
                    
                    Spacer()
                    
                    Text(incomeDate)
                        .font(.system(size: 13))
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                }

                
            }
            .padding(.top, 10)
            
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
        
        
    }
    
    private func deleteIncome() {
        deleteIncomeViewModel.deleteIncome(incomeId: incomeId)
        { success, message in
            DispatchQueue.main.async {
                onDeleteIncome(success, message)
            }
        }
    }
}


struct SavingView: View {
    @StateObject var getSavingViewModel: GetSavingViewModel = GetSavingViewModel()
    
    @StateObject var deleteSavingViewModel : DeleteSavingViewModel = DeleteSavingViewModel()
    
    @State private var isSavingVisible = false
    @State private var deleteSuccess = false
    @State private var errorMessage = ""
    
    var body: some View {
        
        
        
        VStack{
            
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 2)
                    .frame(height: 200)
                    .offset(y: 120)
                
                HStack{
                    Image("Savings")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 60)
                        .scaledToFit()
                        .offset(y: 60)
                }
                
                
                
                HStack(alignment: .center) {
                    
                    Button(action: {
                        deleteAndRefresh()
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .scaledToFit()
                    }
                    .padding(.leading, 20)
                    
                    
                    Text(String(format: "%.2f", getSavingViewModel.sumOfSavingsAmount))
                        .font(.system(size: 30))
                    
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("LKR")
                        .font(.system(size: 10))
                        .padding(.trailing, 20)
                        .padding(.top, 12)
                    
                }
                .offset(y: 120)
                
                
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            
            Spacer()
            NavigationLink(
                destination: AddSavingView(),
                isActive: $isSavingVisible
            ) {
                
            }
            .hidden()
            
            Button(action: {
                
                isSavingVisible = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
            
            
        }
        .onAppear {
            getSavingViewModel.fetchSavingsData()
        }
        .tag(2)
    }
    
    
    func deleteAndRefresh() {
        deleteSavingViewModel.deleteSaving { success, message in
            if success {
                getSavingViewModel.fetchSavingsData()
            } else {
                errorMessage = message
            }
        }
    }
    
}


