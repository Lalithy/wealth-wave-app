//
//  ListOfExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct ListOfExpensesView: View {
    
    @State private var foodSelected = false
    @State private var healthcareSelected = false
    @State private var housingSelected = false
    @State private var insuranceSelected = false
    @State private var transportationSelected = false
    @State private var utilitiesSelected = false
    @State private var personalSpendingSelected = false
    @State private var otherSelected = false
    
    
    let gradientScreen = Gradient(colors: [Color("ScreenColorTop"), Color("ScreenColorMiddle"), Color("ScreenColorEnd")])
    
    var body: some View {
        ScrollView {
            
            VStack {
                HStack {
                    Spacer()
                    Text("EXPENSES")
                        .font(.system(size: 25))
                        .foregroundColor(.red)
                        .bold()
                    Spacer()
                }
                
                ExpenseItemView(isSelected: $foodSelected, image: "Food", buttonText: "Food")
                
                ExpenseItemView(isSelected: $healthcareSelected, image: "Healthcare", buttonText: "Healthcare")
                
                ExpenseItemView(isSelected: $housingSelected, image: "Housing", buttonText: "Housing")
                
                ExpenseItemView(isSelected: $insuranceSelected, image: "Insurance", buttonText: "Insurance")
                
                ExpenseItemView(isSelected: $transportationSelected, image: "Transportation", buttonText: "Transportation")
                
                ExpenseItemView(isSelected: $utilitiesSelected, image: "Utilities", buttonText: "Utilities")
                
                ExpenseItemView(isSelected: $personalSpendingSelected, image: "Personal Spending", buttonText: "Personal Spending")
                
                ExpenseItemView(isSelected: $otherSelected, image: "Other", buttonText: "Other")
                
                Spacer()
            }
            .padding()
        }
        .background(LinearGradient(gradient: gradientScreen, startPoint: .top, endPoint: .bottom))
    }
}

struct ListOfExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfExpensesView()
    }
}

struct ExpenseItemView: View {
    @Binding var isSelected: Bool
    var image: String
    var buttonText: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 20)
                .padding(.leading, 30)
            
            
            NavigationLink(destination: AddExpensesView(itemName: buttonText), isActive: $isSelected) {
                Button(action: {
                    isSelected = true
                }) {
                    Text(buttonText)
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        
                }
            }
            
            Spacer()
        }
    }
}
