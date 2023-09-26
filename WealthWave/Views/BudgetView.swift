//
//  BudgetView.swift
//  WealthWave
//
//  Created by Lali.. on 22/09/2023.
//

import SwiftUI

struct BudgetView: View {
    
    @StateObject var getBudgetVM : GetBudgetViewModel = GetBudgetViewModel()
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
                
                ForEach(getBudgetVM.budget , id: \.budgetCategoryId) { budget in
                    SetBudgetView(image: budget.budgetCategoryName, budgetCategoryName: budget.budgetCategoryName, expense: budget.expense,  estimatedBudget: budget.estimatedBudget, remainingBudget: budget.remainingBudget, spendBarColor:.indigo)
                    
                }
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
            .onAppear {
                getBudgetVM.fetchBudgetList()
            }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}

struct SetBudgetView: View {
    
    var image: String
    let budgetCategoryName: String
    let expense: Double
    let estimatedBudget: Double
    let remainingBudget: Double
    var spendBarColor: Color
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                
                HStack {
                    Text(budgetCategoryName)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    Text(String(expense))
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }
                //.frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            HStack {
                Text("Budget")
                    .font(.system(size: 15))
                
                Text(String(estimatedBudget))
                    .font(.system(size: 15))
                    .padding(.trailing, 40)
                
                Text("Remaining Budget")
                    .font(.system(size: 15))
                
                Text(String(remainingBudget))
                    .font(.system(size: 15))
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 350, height: 8)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: CGFloat(expense) / CGFloat(estimatedBudget) * 350, height: 8)
                    .foregroundColor(spendBarColor)
            }.padding(.bottom,15)
            
        }.padding(.leading,20)
            .padding(.trailing,20)
        
    }
    
    
}



