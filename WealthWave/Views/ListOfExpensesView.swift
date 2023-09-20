//
//  ListOfExpensesView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI

struct ListOfExpensesView: View {
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    let gradientScreen = Gradient(colors: [Color("ScreenColorTop"), Color("ScreenColorMiddle"), Color("ScreenColorEnd")])
    
    var body: some View {
        
            VStack {
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(10)
                        .frame(width: 350, height: 60)
                        .padding(.top, 10)
                    
                    HStack {
                        Spacer()
                        Text("EXPENSES")
                            .font(.system(size: 25))
                            .foregroundColor(.indigo)
                            .padding(.top, 10)
                            .bold()
                        Spacer()
                    }
                }
                
                HStack{
                    Image("Food")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 20)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        
                    Button("Food"){
                    }
                    .font(.system(size: 25))
                    .padding(.top, 30)
                    Spacer()
                }
                
                HStack{
                    Image("Transportation")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 20)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        
                    Button("Transportation"){
                    }
                    .font(.system(size: 25))
                    .padding(.top, 30)
                    Spacer()
                }
                
                
                Spacer()
            }
        
        .background(LinearGradient(gradient: gradientScreen, startPoint: .top, endPoint: .bottom))
    }
}

struct ListOfExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfExpensesView()
    }
}
