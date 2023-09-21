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
