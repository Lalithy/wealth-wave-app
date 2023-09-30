//
//  AddExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct AddExpensesView: View {
    
    var itemName: String
    
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
            
            FiledInputView()
            
            Spacer()
        }
    }
}

struct AddExpensesView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddExpensesView(itemName: "Food")
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
    
    let userId = PropertyModel.shared.getUserId()
    
    let budgetCategoryId = PropertyModel.shared.getCategoryId()
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case expenseAmount, location, description ,saveButton
    }
    
    var body: some View {
        VStack {
            DatePicker("Choose Date", selection: $expenseDate, in: ...Date(), displayedComponents: .date)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal, 100)
            
            
            TextField("Amount", text: Binding(
                get: { expenseAmount },
                set: { newValue in
                    if newValue.count <= 10 {
                        expenseAmount = newValue.filter { "0123456789.".contains($0) }
                    }
                }
            ))
            .padding()
            .multilineTextAlignment(.trailing)
            .frame(width: 320)
            .background(Color.black.opacity(0.1))
            .cornerRadius(15)
            .keyboardType(.decimalPad)
            .focused($focusedField, equals: .expenseAmount)
            .onSubmit {
                focusedField = .location
            }
            
            
            TextField("Location", text: Binding(
                get: { self.location },
                set: { newValue in
                    if newValue.count <= 30 {
                        self.location = newValue
                    }
                }
            ))
            .padding()
            .frame(width: 320)
            .background(Color.black.opacity(0.1))
            .cornerRadius(15)
            .autocapitalization(.none)
            .focused($focusedField, equals: .location)
            .onSubmit {
                focusedField = .description
            }
            
            if location.count == 30 {
                Text("Location cannot exceed 50 characters")
                    .foregroundColor(.red)
                    .padding(.bottom, 5)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            TextField("Description", text: Binding(
                get: { self.expenseDetails },
                set: { newValue in
                    if newValue.count <= 30 {
                        self.expenseDetails = newValue
                    }
                }
            ))
            .padding()
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .frame(width: 320)
            .background(Color.black.opacity(0.1))
            .cornerRadius(15)
            .padding(.bottom, 20)
            .autocapitalization(.none)
            .focused($focusedField, equals: .description)
            .onSubmit {
                focusedField = .saveButton
            }
            
            if expenseDetails.count == 50 {
                Text("Description cannot exceed 200 characters")
                    .foregroundColor(.red)
                    .padding(.bottom, 5)
            }
            
            Button(action: {
                
                addExpensesVM.saveExpense(
                    expenseDetails: expenseDetails,
                    expenseAmount: Double(expenseAmount) ?? 0.0,
                    expenseDate: expenseDate,
                    location: location,
                    budgetCategoryId: budgetCategoryId,
                    userId: userId)
                
                
                addExpensesVM.expensesSuccessCallback = {
                    alertMessage = addExpensesVM.responseMessage
                    showAlert  = true
                }
                
                focusedField = .saveButton
                
            }) {
                Text("Save")
                    .focused($focusedField, equals: .saveButton)
                    .foregroundColor(.white)
                    .frame(width: 320, height: 50)
                    .bold()
                    .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
            .background(Color.clear)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    
                    if addExpensesVM.statusCode == 200 {
                        
                        expenseDetails = ""
                        expenseAmount = ""
                        location = ""
                        
                    }
                    
                }
            }.task{}
            
            Spacer()
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
           
                    Spacer()
                    Button("Done") {
                        focusedField = .expenseAmount
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .focused($focusedField, equals: .expenseAmount)
                
            }
        }
        
        
    }
}







