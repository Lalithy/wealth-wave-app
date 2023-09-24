//
//  AddBudgetView.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import SwiftUI

struct AddBudgetView: View {
    
    @StateObject var addCategoryVM : ListOfExpensesViewModel = ListOfExpensesViewModel()
    @StateObject var addBudgetVM : AddBudgetViewModel = AddBudgetViewModel()
    
    @State private var selectedCategory = ""
    @State private var selectedCategoryId = 1
    @State private var budgetAmount = ""
    @State private var isCalculatorExpanded = true
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    let userId = UserModel.shared.getUserId()
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    
    
    var body: some View {
        
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Text("Add Budget")
                        .font(.system(size: 25))
                        .bold()
                    Spacer()
                }
            }
            
            Image(systemName: "bag.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 20)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            VStack{

                Picker("Category", selection: $selectedCategoryId) {
                    ForEach(addCategoryVM.budgetCategories, id: \.budgetCategoryId) { category in
                        Text(category.budgetCategoryName)
                            .tag(category.budgetCategoryId)
                    }
                }
                .padding()
                .frame(height: 50)
                .clipped()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 20)
                .foregroundColor(Color.black)
                
                TextField("Amount", text: $budgetAmount)
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .disabled(true)
                    .padding(.bottom, 50)
                
                Text("Period for current month")
                    .padding(.bottom, 20)
                    .foregroundColor(.blue)
                    .bold()
                
                
                
                Button(action: {
                    
                    
                    addBudgetVM.saveBudget(
                        
                        budgetAmount: Double(budgetAmount) ?? 0.0,
                        budgetCategoryId: selectedCategoryId,
                        userId: userId)
                    
                    addBudgetVM.budgetSuccessCallback = {
                        alertMessage = addBudgetVM.responseMessage
                        showAlert  = true
                    }
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(width: 320, height: 50)
                        .bold()
                        .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .background(Color.clear)
                .alert(alertMessage, isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        
                        if addBudgetVM.statusCode == 200 {
                            
                            budgetAmount = ""
                            
                        }
                        
                    }
                }
                
                
                Spacer()
            }
            .background(
                
                ZStack(alignment: .bottom) {
                    
                    VStack{
                        Spacer()
                        if isCalculatorExpanded {
                            CalculatorNumberView(amount: $budgetAmount)
                                .transition(.move(edge: .bottom))
                        }
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame( width: 150,height: 5)
                            .onTapGesture {
                                withAnimation {
                                    isCalculatorExpanded.toggle()
                                }
                            }
                    }
                    
                    
                }
            )
        }
    }
}


struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
    }
}
