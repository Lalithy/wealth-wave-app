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
    
    @State private var isCalculatorExpanded = false
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    @FocusState private var isAmountFocused: Bool
    
    let userId = PropertyModel.shared.getUserId()
    
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
                

                TextField("Amount", text: Binding(
                    get: { budgetAmount },
                    set: { newValue in
                        if newValue.count <= 25 {
                            budgetAmount = newValue.filter { "0123456789.".contains($0) }
                        }
                    }
                ))
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.bottom, 50)
                    .keyboardType(.decimalPad)
                    .focused($isAmountFocused)
                
                
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
                }.task{}
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done") {
                    isAmountFocused = false
                }
            }
        }
    }
}


struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
    }
}


