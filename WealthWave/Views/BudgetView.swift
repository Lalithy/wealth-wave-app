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
                    SetBudgetView(image: budget.budgetCategoryName, budgetCategoryName: budget.budgetCategoryName, expense: budget.expense,  estimatedBudget: budget.estimatedBudget, remainingBudget: budget.remainingBudget, spendBarColor:.cyan)
                    
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
        
        ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 2)
                        .frame(height: 80)
                        

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(image)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                            
                            Text(budgetCategoryName)
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", expense))
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                
                HStack {
                    Text("Budget :")
                        .font(.system(size: 13))
                    
                    Text(String(format: "%.2f", estimatedBudget))
                        .font(.system(size: 13))
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text("Remaining :")
                        .font(.system(size: 13))
                    
                    Text(String(format: "%.2f", remainingBudget))
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(.secondary)
      
                ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 350, height: 8)
                                    .foregroundColor(.gray)
                                Rectangle()
                                    .frame(width: CGFloat(min(expense, estimatedBudget)) / CGFloat(estimatedBudget) * 350, height: 8)
                                    .foregroundColor(expense > estimatedBudget ? Color("Personal Spending") : Color("Insurance"))
                            }
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                
    //            Rectangle()
    //                .frame(height: 1)
    //                .foregroundColor(.blue)
                
            }
            .padding(.top, 10)
            .padding(.leading,10)
            .padding(.trailing,10)
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
        
    }
    
    
}



