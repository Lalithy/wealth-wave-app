//
//  ListOfExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct ListOfExpensesView: View {
    @StateObject var listOfExpensesVM: ListOfExpensesViewModel = ListOfExpensesViewModel()


//    @State private var foodSelected = false
//    @State private var healthcareSelected = false
//    @State private var housingSelected = false
//    @State private var insuranceSelected = false
//    @State private var transportationSelected = false
//    @State private var utilitiesSelected = false
//    @State private var personalSpendingSelected = false
//    @State private var otherSelected = false
    
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
                        ExpenseItemView(image: category.budgetCategoryName, buttonText: category.budgetCategoryName)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: gradientScreen, startPoint: .top, endPoint: .bottom))
        .onAppear {
            // Trigger the data loading when the view appears
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
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 10)
                .padding(.leading, 10)
            
            NavigationLink(destination: AddExpensesView(itemName: buttonText), isActive: $isSelected) {
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


//struct ExpenseItemView: View {
//    @Binding var isSelected: Bool
//    var image: String
//    var buttonText: String
//
//    var body: some View {
//        HStack {
//            Image(image)
//                .resizable()
//                .frame(width: 50, height: 50)
//                .padding(.trailing, 10)
//                .padding(.leading, 10)
//
//
//            NavigationLink(destination: AddExpensesView(itemName: buttonText), isActive: $isSelected) {
//                Button(action: {
//                    isSelected = true
//                }) {
//                    Text(buttonText)
//                        .font(.system(size: 20))
//                        .foregroundColor(.black)
//
//                }
//            }
//
//            Spacer()
//        }
//    }
//}


