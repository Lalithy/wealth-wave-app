//
//  AddItemsView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI


struct AddItemsView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            
            HStack {
                TabBarButton(title: "EXPENSES", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabBarButton(title: "INCOME", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                TabBarButton(title: "SAVINGS", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
                
            }
            .padding(.vertical, 10)
            
            
            TabView(selection: $selectedTab) {
                
                ExpensesView()
                
                IncomeView()
                
                SavingView()
                
                
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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
    //    lali4@gmail.com
    
    var body: some View {
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
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                        
                        Text(expenseCategory)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Text(String(format: "%.2f", expenseAmount))
                            .font(.system(size: 15))
                            .padding(.trailing, 20)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            
            HStack {
                Text(expenseDetails)
                    .font(.system(size: 15))
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text(expenseDate)
                    .font(.system(size: 13))
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.blue)
            
        }
        
        .padding(.top, 10)
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
    
    var body: some View {
        VStack {
            
            Text("Total : \(incomeViewModel.totalAmount)")
                .bold()
                .padding(.top, 10)
                .font(.system(size: 25))
                .frame(maxWidth: .infinity, alignment: .center)
           
            
            HStack {
                VStack {
                    Text("Date")
                        .font(.headline)
                        .padding(.leading, 20)
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
                .foregroundColor(.blue)

            
            ScrollView {
                ForEach(incomeViewModel.incomeData, id: \.incomeId) { item in
                    UserIncomeListView(incomeDate: item.incomeDate, incomeDetails: item.incomeDetails, incomeAmount: item.incomeAmount)
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
    
    var incomeDate: String
    var incomeDetails: String
    var incomeAmount: Double
    
    var body: some View {
    
        HStack {
            VStack {
                Text(incomeDate)
                    .font(.system(size: 15))
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Text(incomeDetails)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Text(String(format: "%.2f", incomeAmount))
                    .font(.system(size: 15))
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.top, 10)
        
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.blue)
        
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
            
            HStack {
                
                Button(action: {
                    deleteAndRefresh()
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                        .scaledToFit()
                }
                .padding(.leading, 20)
                
                
                Text("Savings")
                    .font(.system(size: 25))
                
                
                Text(String(format: "%.2f", getSavingViewModel.sumOfSavingsAmount))
                    .font(.system(size: 25))
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 10)
            
            
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


