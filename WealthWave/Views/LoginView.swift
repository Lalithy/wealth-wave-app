//
//  LoginView.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    let gradient = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    
    var body: some View {
  
            VStack{
                            HStack {
                                Spacer()
                                Image("LOGO")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .padding(.top, 20)
                                Spacer()
                            }
                Spacer().frame(height:40)
                HStack{
                    Text("Sign up with your email address")
                        .bold()
                }
                
               Spacer().frame(height:40)
               TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(15)
                
                Spacer().frame(height:20)
                TextField("Password", text: $password)
                     .padding()
                     .frame(width: 300)
                     .background(Color.black.opacity(0.05))
                     .cornerRadius(15)
                
                Spacer().frame(height:50)
                Button("Login"){
                    
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .bold()
                .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                
                Spacer()
                
            }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
