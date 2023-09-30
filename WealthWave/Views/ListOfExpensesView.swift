//
//  ListOfExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct ListOfExpensesView: View {
    
    @StateObject var listOfExpensesVM: ListOfExpensesViewModel = ListOfExpensesViewModel()
    
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Expenses")
                    .font(.system(size: 25))
                    .bold()
                Spacer()
            }
            
            //            if listOfExpensesVM.isLoading {
            //                ProgressView()
            //            } else {
            ScrollView {
                ForEach(listOfExpensesVM.budgetCategories, id: \.budgetCategoryId) { category in
                    ExpenseItemView(image: category.budgetCategoryName, buttonText: category.budgetCategoryName, budgetCategoryId: category.budgetCategoryId)
                }
                Spacer()
            }
            //            }
        }
        .padding()
        
        .onAppear {
            listOfExpensesVM.fetchBudgetCategories()
        }
    }
}


struct ListOfExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfExpensesView()
    }
}

struct ExpenseItemView: View {
    @State private var isSelected = false
    var image: String
    var buttonText: String
    var budgetCategoryId: Int
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 2)
                .frame(height: 80)
            
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                
                NavigationLink(destination: AddExpensesView(itemName: buttonText), isActive: $isSelected) {
                    Button(action: {
                        isSelected.toggle()
                        
                        PropertyModel.shared.saveCategoryId(budgetCategoryId)
                    }) {
                        Text(buttonText)
                            .font(.system(size: 20))
                            .foregroundColor(isSelected ? .blue : .black)
                    }
                }
                
                Spacer()
            }
            
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
        
    }
}
