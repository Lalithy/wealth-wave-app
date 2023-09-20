//  RegisterView.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerVM : RegisterViewModel = RegisterViewModel()
    @State private var showSuccessMessage = false
    @FocusState var focus
    
    
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
            
            TextField("Enter Email", text: $registerVM.email)
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .focused($focus)
            
            TextField("Enter Password", text: $registerVM.password)
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding()
                .focused($focus)
            
            TextField("Confirm Password", text: $registerVM.confirmPassword)
                .padding()
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 50)
                .focused($focus)
            
            
            Button("Login"){
                registerVM.registrationSuccessCallback = {
                            self.showSuccessMessage = true
                        }
                
                registerVM.registerUser()
                
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .bold()
            .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.bottom, 40)
            .alert(isPresented: $showSuccessMessage) {
                    Alert(
                        title: Text("Successful"),
                        message: Text("User created successfully!"),
                        dismissButton: .default(Text("OK")) {

                        }
                    )
                }
            
            Spacer()
            
        }.background(LinearGradient(gradient: gradientBackground, startPoint: .top, endPoint: .bottom))
        
            
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
