//  RegisterView.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerVM : RegisterViewModel = RegisterViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isStatusCode = false
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password, confirmPassword
    }
    
    
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
                .autocapitalization(.none)
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .focused($focusedField, equals: .email)
                .onSubmit {
                    focusedField = .password
                }
               
            
            TextField("Enter Password", text: $password)
                .padding()
                .autocapitalization(.none)
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding()
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .confirmPassword
                }
                
            
            TextField("Confirm Password", text: $confirmPassword)
                .padding()
                .autocapitalization(.none)
                .frame(width: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.bottom, 50)
                .focused($focusedField, equals: .confirmPassword)
               
            
            
            Button("Login"){

                registerVM.saveRegister(
                    email: email,
                    password: password,
                    confirmPassword: confirmPassword)
                
                
                registerVM.registrationSuccessCallback = {
                    alertMessage = registerVM.responseMessage
                    showAlert  = true
                }
                
                
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .bold()
            .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.bottom, 40)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    
                    if registerVM.statusCode == 200 {
                        
                        isStatusCode = true
                        
                        
                    }
                    
                }
            }
            
            Spacer()
            
        }.background(LinearGradient(gradient: gradientBackground, startPoint: .top, endPoint: .bottom))
        .onAppear {
                DispatchQueue.main.async {
                    focusedField = .email
                }
            }
        
            
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
