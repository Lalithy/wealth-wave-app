//
//  AddIncomeView.swift
//  WealthWave
//
//  Created by Lali.. on 21/09/2023.
//

import SwiftUI

struct AddIncomeView: View {
    
    @StateObject var addIncomeVM : AddIncomeViewModel = AddIncomeViewModel()
    
    @State private var incomeDate = Date()
    @State private var incomeAmount = ""
    @State private var incomeDetails = ""
    @State private var isCalculatorExpanded = true
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case incomeAmount, incomeDetails
    }
    
    let userId = PropertyModel.shared.getUserId()
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    var body: some View {
        
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Text("Add Income")
                        .font(.system(size: 25))
                        .bold()
                    Spacer()
                }
            }
            
            Image(systemName: "dollarsign.arrow.circlepath")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 20)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            
            VStack{
                
                DatePicker("Choose Date", selection: $incomeDate, in: ...Date(), displayedComponents: .date)
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal, 100)
                

                TextField("Amount", text: Binding(
                    get: { incomeAmount },
                    set: { newValue in
                        if newValue.count <= 10 {
                            incomeAmount = newValue.filter { "0123456789.".contains($0) }
                        }
                    }
                ))
                .padding()
                .multilineTextAlignment(.trailing)
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .keyboardType(.decimalPad)
                .focused($focusedField, equals: .incomeAmount)
                .onSubmit {
                    focusedField = .incomeDetails
                }
                
                TextField("Description", text: Binding(
                    get: { self.incomeDetails },
                    set: { newValue in
                        if newValue.count <= 30 {
                            self.incomeDetails = newValue
                        }
                    }
                ))
                .padding()
                .focused($focusedField, equals: .incomeDetails)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom,20)
                
                if incomeDetails.count == 50 {
                    Text("Description cannot exceed 200 characters")
                        .foregroundColor(.red)
                        .padding(.bottom, 5)
                }
                
                Button(action: {

                    addIncomeVM.saveIncome(
                        incomeDetails: incomeDetails,
                        incomeAmount: Double(incomeAmount) ?? 0.0,
                        incomeDate: incomeDate,
                        userId: userId)
                    
                    addIncomeVM.incomeSuccessCallback = {
                        alertMessage = addIncomeVM.responseMessage
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
                        
                        if addIncomeVM.statusCode == 200 {
                            
                            incomeDetails = ""
                            incomeAmount = ""
                            
                        }
                        
                    }
                }
                .task{}
                
                Spacer()
            }
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
              
                    Spacer()
                    Button("Done") {
                        focusedField = .incomeAmount
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .focused($focusedField, equals: .incomeAmount)
                
            }
        }
    }
}

struct AddIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        AddIncomeView()
    }
}

