//
//  ListOfExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct ListOfExpensesView: View {
    @StateObject var listOfExpensesVM: ListOfExpensesViewModel = ListOfExpensesViewModel()

    
    let gradientScreen = Gradient(colors: [Color("ScreenColorTop"), Color("ScreenColorMiddle"), Color("ScreenColorEnd")])
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("EXPENSES")
                    .font(.system(size: 25))
                    .bold()
                Spacer()
            }
            
            if listOfExpensesVM.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    ForEach(listOfExpensesVM.budgetCategories, id: \.budgetCategoryId) { category in
                        ExpenseItemView(image: category.budgetCategoryName, buttonText: category.budgetCategoryName, budgetCategoryId: category.budgetCategoryId)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: gradientScreen, startPoint: .top, endPoint: .bottom))
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
        HStack {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 10)
                .padding(.leading, 10)
            
            NavigationLink(destination: AddExpensesView(itemName: buttonText,  budgetCategoryId: budgetCategoryId), isActive: $isSelected) {
                Button(action: {
                    isSelected.toggle()
                }) {
                    Text(buttonText)
                        .font(.system(size: 20))
                        .foregroundColor(isSelected ? .blue : .black)
                }
            }
            
            Spacer()
        }
    }
}
