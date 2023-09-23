//
//  AddSavingView.swift
//  WealthWave
//
//  Created by Lali.. on 21/09/2023.
//

import SwiftUI

struct AddSavingView: View {
    
    @StateObject var addSavingVM : AddSavingViewModel = AddSavingViewModel()
    
    @State private var savingsDate = Date()
    @State private var savingsAmount = ""
    @State private var savingsDetails = ""
    @State private var isCalculatorExpanded = true
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case savingsDetails
    }
    
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    var body: some View {
        
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Text("Add Savings")
                        .font(.system(size: 25))
                        .bold()
                    Spacer()
                }
            }
            
            Image(systemName: "dollarsign.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 20)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            
            VStack{
                DatePicker("Choose Date", selection: $savingsDate, in: ...Date(), displayedComponents: .date)
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal, 100)
                
                TextField("Amount", text: $savingsAmount)
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .disabled(true)
                    .padding(.bottom,20)
                
                
                Button(action: {
                    
                    addSavingVM.saveSaving(
                        savingsDetails: "Savings",
                        savingsAmount: Double(savingsAmount) ?? 0.0,
                        savingsDate: savingsDate,
                        userId: 1)
                    
                    
                    addSavingVM.saveSuccessCallback = {
                        alertMessage = addSavingVM.responseMessage
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
                        
                        if addSavingVM.statusCode == 200 {
                            
                            savingsDetails = ""
                            savingsAmount = ""

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
                            CalculatorNumberView(amount: $savingsAmount)
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

struct AddSavingView_Previews: PreviewProvider {
    static var previews: some View {
        AddSavingView()
    }
}
