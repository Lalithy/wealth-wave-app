//
//  RegisterView.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    let gradientBackground = Gradient(colors: [Color("BackgroundTop"), Color("BackgroundMiddle"), Color("BackgroundEnd")])
    
    var body: some View {
        
        VStack{
            
            HStack{
                Spacer()
                Text("Register")
                    .font(.title)
                    .padding()
                Spacer()
            }
            .padding(.bottom, 50)
            
            TextField("Enter Email", text: $email)
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
            
            TextField("Enter Password", text: $password)
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding()
            
            TextField("Confirm Password", text: $passwordConfirm)
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 50)
            
            
            Button("Login"){
                
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .bold()
            .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.bottom, 40)
            
            
            Spacer()
            
        }.background(LinearGradient(gradient: gradientBackground, startPoint: .top, endPoint: .bottom))
            
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
