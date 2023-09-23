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
    
    @State private var isListVisible = false
    @State private var foodSelected = false
    @State private var healthcareSelected = false
    
    var body: some View {
        VStack {
            
            UserExpensesListView(isSelected: $foodSelected, iconName: "minus.circle.fill",image: "Food", itemName: "Food", editIcon: "square.and.pencil")
            
            UserExpensesListView(isSelected: $healthcareSelected, iconName: "minus.circle.fill",image: "Healthcare", itemName: "Healthcare",  editIcon: "square.and.pencil")
            
            
            UserExpensesListView(isSelected: $healthcareSelected, iconName: "minus.circle.fill",image: "Personal Spending", itemName: "Personal Spending",  editIcon: "square.and.pencil")
            
            Spacer()
            
            NavigationLink(
                destination: ListOfExpensesView(),
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
            
        }.tag(0)
    }
}

struct UserExpensesListView: View {
    @Binding var isSelected: Bool
    var iconName: String
    var image: String
    var itemName: String
    var editIcon: String
        
    var body: some View {
       
        HStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: iconName)
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                        .scaledToFit()
                }
                .padding(.leading, 10)

                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 10)
                    .scaledToFit()
                
                Text(itemName)
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                Spacer()
                
                
                NavigationLink(
                    destination: EditExpensesView(itemName: itemName),
                    isActive: $isSelected
                ) {
                }
                .hidden()
                
                Button(action: {
                    
                    isSelected = true
                }) {
                    Image(systemName: editIcon)
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                        .scaledToFit()
                }
                .padding(.trailing, 20)
            }
            
        }
        .padding(.top, 10)

    }
}


struct IncomeItem: Identifiable {
    let id = UUID()
    let date: Date
    let description: String
    let amount: Double
}


struct IncomeView: View {
    
    @State private var isIncomeVisible = false
    
    let incomeData: [IncomeItem] = [
        IncomeItem(date: Date(), description: "Salary", amount: 1000.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Salary", amount: 1000.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Salary", amount: 1000.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Salary", amount: 1000.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
        IncomeItem(date: Date(), description: "Freelance work", amount: 500.0),
       
    ]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Total: ")
                    .font(.system(size: 25))
                    .bold()
                    .padding(.top, 10)
                Spacer()
            }

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

            ScrollView {
                LazyVStack {
                    ForEach(incomeData) { item in

                        VStack{
                            HStack {
                        
                                Text(item.date, style: .date)
                                    .padding(.trailing, 30)
                                Text(item.description)
                                    .padding(.trailing, 30)
                                Text(String(format: "%.2f", item.amount))
                                    .padding(.leading, 30)
                            }
                        }
                        
                    }
                }
            }
            //.frame(maxHeight: 700)
            
            
            Spacer()
            
            NavigationLink(
                destination: AddIncomeView(),
                isActive: $isIncomeVisible
            ) {
                
            }
            .hidden()
            
            Button(action: {
                
                isIncomeVisible = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
        }
        .tag(1)
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
            
        }.tag(2)
    }
}



