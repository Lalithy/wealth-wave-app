//
//  BudgetView.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import SwiftUI

struct BudgetView: View {
    
    @State private var isBudgetVisible = false
    
    var body: some View {
        
        VStack{
            ZStack{
                HStack {
                    Spacer()
                    Text("Budget")
                        .font(.system(size: 25))
                        .bold()
                    Spacer()
                }
            }
            
            ScrollView {
                SetBudgetView(image: "Food", itemName: "Food", spendAmount: 1000.00, totalTitle: "Total: ",subTitle: "Remaining Budget:", totalAmount: 5000.00,remainingAmount: 4000.00, spendBarColor: .blue)
                
                
                SetBudgetView(image: "Healthcare", itemName: "Healthcare", spendAmount: 3000.00, totalTitle: "Total: ",subTitle: "Remaining Budget:", totalAmount: 7000.00,remainingAmount: 4000.00, spendBarColor: .green)
                
                SetBudgetView(image: "Transportation", itemName: "Transportation", spendAmount: 2500.00, totalTitle: "Total: ",subTitle: "Remaining Budget:", totalAmount: 9000.00,remainingAmount: 6500.00, spendBarColor:.indigo)
                
                
            }
            
            Spacer()
            
            NavigationLink(
                destination: AddBudgetView(),
                isActive: $isBudgetVisible
            ) {
                
            }
            .hidden()
            
            Button(action: {
                
                isBudgetVisible = true
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
            
        }.tag(2)
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}

struct SetBudgetView: View {
    
    var image: String
    var itemName: String
    var spendAmount: Double
    var totalTitle: String
    var subTitle: String
    var totalAmount: Double
    var remainingAmount: Double
    var spendBarColor: Color
    
    var body: some View {
        
      
        VStack(alignment: .leading) {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                
                HStack {
                    Text(itemName)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    Text(String(spendAmount))
                        .font(.system(size: 20))
                }
                //.frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            HStack {
                Text(totalTitle)
                    .font(.system(size: 15))
                
                Text(String(totalAmount))
                    .font(.system(size: 15))
                    .padding(.trailing, 40)
                
                Text(subTitle)
                    .font(.system(size: 15))
                
                Text(String(remainingAmount))
                    .font(.system(size: 15))
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 350, height: 8)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: CGFloat(spendAmount) / CGFloat(totalAmount) * 350, height: 8)
                    .foregroundColor(spendBarColor)
            }.padding(.bottom,15)
            
        }.padding(.leading,20)
        .padding(.trailing,20)
        
    }
    
    
}



