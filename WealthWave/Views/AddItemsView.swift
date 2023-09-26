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

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    deleteExpense()
                }) {
                    Image(systemName: iconName)
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                        .scaledToFit()
                }
                .disabled(deleteExpensesViewModel.isDeleting)

                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()

                Text(expenseCategory)
                    .font(.system(size: 20))
                    .padding(.leading, 10)

                Text(String(format: "%.2f", expenseAmount))
                    .font(.system(size: 20))
            }

            HStack {
                Text(expenseDetails)
                    .font(.system(size: 20))

                Text(expenseDate)
                    .font(.system(size: 20))
            }
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



//struct ExpensesView: View {
//
//    @StateObject var userExpensesList: GetExpensesViewModel = GetExpensesViewModel()
//    @State private var isListVisible = false
//
//
//
//    var body: some View {
//        VStack {
//
//
//            ScrollView {
//                ForEach(userExpensesList.expenses, id: \.expenseId) { item in
//                    UserExpensesListView(iconName: "minus.circle.fill",image: item.expenseCategory, expenseCategory: item.expenseCategory, expenseAmount: item.expenseAmount, expenseDetails: item.expenseDetails, expenseDate: item.expenseDate, expenseId: item.expenseId)
//                }
//
//            }
//
//
//            Spacer()
//
//            NavigationLink(
//                destination: ListOfExpensesView(),
//                isActive: $isListVisible
//            ) {
//
//            }
//            .hidden()
//
//            Button(action: {
//
//                isListVisible = true
//            }) {
//                Image(systemName: "plus.circle")
//                    .font(.system(size: 40))
//                    .foregroundColor(.blue)
//            }
//            .padding(.bottom, 20)
//            .padding(.trailing, 20)
//
//
//        }.tag(0)
//            .onAppear {
//                userExpensesList.fetchExpensesList()
//            }
//    }
//}
//
//struct UserExpensesListView: View {
//    @StateObject var deleteExpensesViewModel = DeleteExpensesViewModel()
//
//    var iconName: String
//    var image: String
//    var expenseCategory: String
//    var expenseAmount: Double
//    var expenseDetails: String
//    var expenseDate: String
//    var expenseId: Int
//
//    var body: some View {
//
//        VStack {
//            HStack {
//                Button(action: {
//                    deleteExpense()
//                }) {
//                    Image(systemName: iconName)
//                        .font(.system(size: 30))
//                        .foregroundColor(.red)
//                        .scaledToFit()
//                }
//                .disabled(deleteExpensesViewModel.isDeleting)
//                //.padding(.leading, 10)
//
//                Image(image)
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                //.padding(.leading, 10)
//                    .scaledToFit()
//
//                Text(expenseCategory)
//                    .font(.system(size: 20))
//                    .padding(.leading, 10)
//
//                Text(String(format: "%.2f", expenseAmount))
//                    .font(.system(size: 20))
//                //.padding(.leading, 10)
//                //Spacer()
//
//            }
//            //Spacer()
//            HStack {
//                Text(expenseDetails)
//                    .font(.system(size: 20))
//                //.padding(.leading, 10)
//
//                Text(expenseDate)
//                    .font(.system(size: 20))
//                //.padding(.leading, 10)
//                //Spacer()
//            }
//
//        }
//        .padding(.top, 10)
//
//    }
//
//    private func deleteExpense() {
//        deleteExpensesViewModel.deleteExpense(expenseId: expenseId) {
//            // Handle completion here, e.g., refresh the view
//            if deleteExpensesViewModel.deleteError == nil {
//                // Refresh your expenses list here after successful deletion
//                deleteExpensesViewModel.expenseDeleted = true
//            } else {
//                // Handle error
//                print("Error deleting expense: \(deleteExpensesViewModel.deleteError?.localizedDescription ?? "Unknown error")")
//            }
//        }
//    }
//}






struct IncomeView: View {
    
    @StateObject var incomeViewModel: IncomeViewModel = IncomeViewModel()
    @State private var isIncomeVisible = false
    @State private var isListVisible = false
    
    var body: some View {
        VStack {
            
            Text("Total: \(incomeViewModel.totalAmount)")
                .font(.system(size: 25))
                .bold()
                .padding(.top, 10)
            
            HStack {
                Text("Date")
                    .font(.headline)
                    .padding(.trailing, 30)
                Text("Description")
                    .font(.headline)
                    .padding(.trailing, 30)
                Text("Amount")
                    .font(.headline)
                    .padding(.leading, 30)
            }
            .padding(.top, 10)
            
            //            if userExpensesList.isLoading {
            //                ProgressView()
            //            } else {
            ScrollView {
                ForEach(incomeViewModel.incomeData, id: \.incomeId) { item in
                    UserIncomeListView(incomeDate: item.incomeDate, incomeDetils: item.incomeDetails ,incomeAmount: item.incomeAmount)
                    
                }
                //Spacer()
            }
            //            }
            
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
    var incomeDetils: String
    var incomeAmount: Double
    
    var body: some View {
        
        VStack {
            HStack {
                
                //.padding(.leading, 10)
                
                Text(incomeDate)
                    .font(.system(size: 10))
                
                Text(incomeDetils)
                    .font(.system(size: 20))
                
                Text(String(format: "%.2f", incomeAmount))
                    .font(.system(size: 20))
                //.padding(.leading, 10)
                //Spacer()
                
            }
            //Spacer()
            
            
        }
        .padding(.top, 10)
        
    }
}


struct SavingView: View {
    @StateObject var getSavingViewModel: GetSavingViewModel = GetSavingViewModel()
    
    @State private var isSavingVisible = false
    
    
    var body: some View {
        VStack{
            
            HStack {
                
                Button(action: {}) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                        .scaledToFit()
                }
                .padding(.leading, 10)
                
                
                Text("Savings")
                    .font(.system(size: 25))
                    .padding(.leading, 10)
                
                Text(String(format: "%.2f", getSavingViewModel.sumOfSavingsAmount))
                    .font(.system(size: 25))
                    .padding(.leading, 80)
                
            }//.padding(.bottom, 300)
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
}


