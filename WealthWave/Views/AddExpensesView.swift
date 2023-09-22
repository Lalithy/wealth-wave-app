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
    
    @ObservedObject var addExpensesVM = AddExpensesViewModel()
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    var budgetCategoryId: Int
    
    @State private var expenseDate = Date()
    @State private var expenseAmount = ""
    @State private var location = ""
    @State private var expenseDetails = ""
    @State private var calculatorHeight: CGFloat = 0
    @State private var isCalculatorExpanded = false
    
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
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
                .disabled(true)
            
            TextField("Location", text: $location)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
            
            TextField("Description", text: $expenseDetails)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 20)
            
            Button("SAVE"){
                addExpensesVM.saveExpense(
                                expenseDetails: expenseDetails,
                                expenseAmount: Double(expenseAmount) ?? 0.0,
                                expenseDate: expenseDate,
                                location: location,
                                budgetCategoryId: budgetCategoryId,
                                userId: 1                             )
                
                print("Expenses : \(addExpensesVM.statusCode)")
            }
            .foregroundColor(.white)
            .frame(width: 320, height: 50)
            .bold()
            .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .onTapGesture {
                print("Button tapped") 
                print("Expenses : \(addExpensesVM.statusCode)")

                
                alertMessage = addExpensesVM.responseMessage
                isShowingAlert = true

               
                if addExpensesVM.statusCode == 200 {
                    
                    expenseDetails = ""
                    expenseAmount = ""
                    location = ""
                   
                }
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Response"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

            
            Spacer()
            
            Text(addExpensesVM.responseMessage)
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
        )
    }
}




