//
//  EditExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 21/09/2023.
//

import SwiftUI

struct EditExpensesView: View {
    
    var itemName: String 
    var body: some View {
        
        VStack {
            ZStack{
                HStack {
                    Spacer()
                    Text("Edit Expenses")
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

 
            EditInputView()
            
            Spacer()
        }
        
        
    }
}

struct EditExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        EditExpensesView(itemName: "Food")
    }
}

struct CalculatorNumberView: View {
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


struct EditInputView: View {
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    @State private var date = ""
    @State private var selectedDate = Date()
    @State private var amount = ""
    @State private var location = ""
    @State private var description = ""
    @State private var calculatorHeight: CGFloat = 0
    @State private var isCalculatorExpanded = false
    
    var body: some View {
        VStack {
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
            
            TextField("Location", text: $location)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
            
            TextField("Description", text: $description)
                .padding()
                .frame(width: 320)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 20)
            
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


