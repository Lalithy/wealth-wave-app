//
//  AddExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct AddExpensesView: View {
    
    var itemName: String
    
    var budgetCategoryId: Int
    
    var body: some View {
        
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Text("Add Expenses")
                        .font(.system(size: 25))
                        .bold()
                    Spacer()
                }
            }
            
            
            Image(itemName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 20)
            
            TextField("", text: .constant(itemName))
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.top, 10)
                .disabled(true)
            
            FiledInputView(budgetCategoryId: budgetCategoryId)
            
            Spacer()
        }
    }
}

struct AddExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpensesView(itemName: "Food", budgetCategoryId: 1)
    }
}


struct CalculatorNumberPadView: View {
    @Binding var amount: String
    
    let buttonRows = [
        ["7", "8", "9"],
        ["4", "5", "6"],
        ["1", "2", "3"],
        [".", "0", "C"]
    ]
    
    var body: some View {
        VStack {
            ForEach(buttonRows, id: \.self) { row in
                HStack {
                    Spacer()
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            if button == "C" {
                                self.amount = ""
                            } else {
                                self.amount += button
                            }
                        }) {
                            Text(button)
                                .font(.title)
                                .frame(width: 90, height: 40)
                                .background(Color.gray)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}


struct FiledInputView: View {
    
    
    @StateObject var addExpensesVM : AddExpensesViewModel = AddExpensesViewModel()
    
    @State private var expenseDate = Date()
    @State private var expenseAmount = ""
    @State private var location = ""
    @State private var expenseDetails = ""
    @State private var calculatorHeight: CGFloat = 0
    @State private var isCalculatorExpanded = true
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    var budgetCategoryId: Int
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case location, description, saveButton
    }

    var body: some View {
        VStack {
            DatePicker("Choose Date", selection: $expenseDate, in: ...Date(), displayedComponents: .date)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal, 100)
            
            TextField("Amount", text: $expenseAmount)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .multilineTextAlignment(.trailing)
                .disabled(true)
            
            TextField("Location", text: $location)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .autocapitalization(.none)
                .focused($focusedField, equals: .location)
                .onSubmit {
                    focusedField = .description
                }
            
            TextField("Description", text: $expenseDetails)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 20)
                .autocapitalization(.none)
                .focused($focusedField, equals: .description)
                .onSubmit {
                    focusedField = .saveButton
                }
            
            
            Button("SAVE"){
                
                addExpensesVM.saveExpense(
                    expenseDetails: expenseDetails,
                    expenseAmount: Double(expenseAmount) ?? 0.0,
                    expenseDate: expenseDate,
                    location: location,
                    budgetCategoryId: budgetCategoryId,
                    userId: 1)
                
                
                addExpensesVM.expensesSuccessCallback = {
                    alertMessage = addExpensesVM.responseMessage
                    showAlert  = true
                }
                
                focusedField = .saveButton
                
            }
            .focused($focusedField, equals: .saveButton)
            .foregroundColor(.white)
            .frame(width: 320, height: 50)
            .bold()
            .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {

                    if addExpensesVM.statusCode == 200 {
                        
                        expenseDetails = ""
                        expenseAmount = ""
                        location = ""
                        
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
                        CalculatorNumberPadView(amount: $expenseAmount)
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
        )  .onAppear {
            DispatchQueue.main.async {
                focusedField = .location
            }
        }
        
        
    }
}







