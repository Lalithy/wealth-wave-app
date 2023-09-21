//
//  AddIncomeView.swift
//  WealthWave
//
//  Created by Lali.. on 21/09/2023.
//

import SwiftUI

struct AddIncomeView: View {
    
 
    @State private var selectedDate = Date()
    @State private var amount = ""
    @State private var description = ""
    @State private var isCalculatorExpanded = false
    
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
                DatePicker("Choose Date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal, 100)
                
                TextField("Amount", text: $amount)
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .disabled(true)
                
                TextField("Description", text: $description)
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.bottom,20)
                
                Button("SAVE"){
                   
                }
                .foregroundColor(.white)
                .frame(width: 320, height: 50)
                .bold()
                .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                
                Spacer()
            }
            .background(
                
                ZStack(alignment: .bottom) {
                    
                    VStack{
                        Spacer()
                        if isCalculatorExpanded {
                            CalculatorNumberView(amount: $amount)
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

struct AddIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        AddIncomeView()
    }
}

struct CalculatorView: View {
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
