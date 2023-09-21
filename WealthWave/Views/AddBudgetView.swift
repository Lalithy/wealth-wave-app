//
//  AddBudgetView.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import SwiftUI

struct AddBudgetView: View {
    
    @State private var selectedCategory = ""
    @State private var amount = ""
    @State private var description = ""
    @State private var isCalculatorExpanded = false
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    var categories = ["Food", "Healthcare", "Housing", "Insurance", "Transportation", "Utilities", "Personal Spending", "Other"]
    
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
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                        .foregroundColor(Color.black)
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
                
                TextField("Amount", text: $amount)
                    .padding()
                    .frame(width: 320)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .disabled(true)
                    .padding(.bottom, 50)
                
                Text("Period for current month")
                    .padding(.bottom, 20)
                    .foregroundColor(.blue)
                    .bold()
                
                Button("SAVE") {
                    
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


struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
    }
}
