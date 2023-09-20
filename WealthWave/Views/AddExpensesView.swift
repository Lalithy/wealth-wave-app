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
                Rectangle()
                    .fill(Color(red: 0.5, green: 0.2, blue: 0.7, opacity: 0.4))
                    .cornerRadius(10)
                    .frame(width: 350, height: 60)
                    .padding(.top, 10)
                
                HStack {
                    Spacer()
                    Text("Add Expenses")
                        .font(.system(size: 25))
                        .padding(.top, 10)
                        .bold()
                    Spacer()
                }
            }
            
            HStack{
                VStack{
                    Image(itemName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 20)
                        .padding(.top, 30)
                    
                }
                
                VStack{
                    
                    TextField("", text: .constant(itemName))
                        .padding()
                        .frame(width: 250)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(15)
                        .padding(.top, 30)
                        .disabled(true)
                    
                }
            }
            
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
                                .frame(width: 100, height: 50)
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
                .frame(width: 250)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal, 100)
            
            TextField("Amount", text: $amount)
                .padding()
                .frame(width: 250)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .disabled(true)
            
            TextField("Location", text: $location)
                .padding()
                .frame(width: 250)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
            
            TextField("Description", text: $description)
                .padding()
                .frame(width: 250)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
            Spacer()
        }
        
        .padding(.leading, 75)
       
        .background(
            
                    ZStack(alignment: .bottom) {
                       
                        VStack{
                            Spacer()
                            if isCalculatorExpanded {
                                CalculatorNumberPadView(amount: $amount)
                                    .transition(.move(edge: .bottom))
                            }
                            
                            // Replace the button with a clickable Rectangle
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




