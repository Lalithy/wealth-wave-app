//
//  LoginView.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    let gradientBackground = Gradient(colors: [Color("BackgroundTop"), Color("BackgroundMiddle"), Color("BackgroundEnd")])
    
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
            HStack{
                
                Text("Sign up with your email address")
                    .bold()
            }.padding(.top, 20)
             .padding(.bottom,40)
            
            
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
                .padding(.bottom, 20)
            
            
            Button(action: {
                
            }) {
                NavigationLink(destination: DashboardView()) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .bold()
                        .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
            }
            
            
            
            HStack{
                Text("Don't have an account?")
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("Register")
                            .foregroundColor(.gray)
                            .bold()
                            .underline(true, color: .gray)
                    }
                )
            }
            
            Spacer()
            
        }.background(LinearGradient(gradient: gradientBackground, startPoint: .top, endPoint: .bottom))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
