//
//  Preview.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import SwiftUI

struct Preview: View {
    @State private var isLoginViewActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink("", destination: LoginView(), isActive: $isLoginViewActive)
                
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                HStack {
                    Text("WealthWave")
                        .font(.system(size: 24))
                        .foregroundColor(Color(hue: 0.666, saturation: 1.0, brightness: 0.57))
                }
                HStack{
                    Text("Ride the Wave to Financial Prosperity")
                        .foregroundColor(Color(hue: 0.666, saturation: 1.0, brightness: 0.57))
                }
                
                Spacer()
                Spacer()
            }
            
        } .onTapGesture {
            isLoginViewActive = true
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Preview_Previews: PreviewProvider {
    
    static var previews: some View {
        Preview()
        
    }
}

