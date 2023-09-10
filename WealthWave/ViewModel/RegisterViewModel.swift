//
//  RegisterViewModel.swift
//  WealthWave
//
//  Created by Lali.. on 10/09/2023.
//

import Foundation
import SwiftUI

class RegisterViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    
    @Published var showSignInView : Bool = false
   
    
}
