//
//  LoginView.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var addLoginVM : LoginViewModel = LoginViewModel()
    
    @StateObject var getSavingVM = GetSavingViewModel()
    
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isStatusCode = false
    
    @State private var userId: Int = 0
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password, saveButton
    }
    
    
    let gradientButton = Gradient(colors: [Color("ButtonColourTop"), Color("ButtonColourMiddle"), Color("ButtonColourEnd")])
    let gradientBackground = Gradient(colors: [Color("BackgroundTop"), Color("BackgroundMiddle"), Color("BackgroundEnd")])
    
    var body: some View {
        
        
        VStack{
            
            NavigationLink(destination: DashboardView(), isActive: $isStatusCode) {
                EmptyView()
            }
            .hidden()
            
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
                .padding(.bottom, 20)
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .saveButton
                }
            
            
            Button(action: {
                
                addLoginVM.saveLogin(
                    email: email,
                    password: password)
                
                addLoginVM.loginSuccessCallback = {
                    alertMessage = addLoginVM.responseMessage
                    
                    if addLoginVM.statusCode == 200 {
                        isStatusCode = true

                        //getSavingVM.userId = userId

                        userId = addLoginVM.userId
                        print("data user id login:  \(userId)")
                        email = ""
                        password = ""
                        
                      //getSavingVM.fetchSavingsData()

                        PropertyModel.shared.saveUserId(userId)
                    }else {
                        showAlert = true
                    }
                    
                }
                
                focusedField = .saveButton
            })
            {
                Text("Login")
                    .focused($focusedField, equals: .saveButton)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .bold()
                    .background(LinearGradient(gradient: gradientButton, startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.bottom, 40)
            }
            .background(Color.clear)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    
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
            .onAppear {
                DispatchQueue.main.async {
                    focusedField = .email
                }
            }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}
