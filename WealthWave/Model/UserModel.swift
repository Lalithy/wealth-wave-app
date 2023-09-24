//
//  UserModel.swift
//  WealthWave
//
//  Created by Lali.. on 24/09/2023.
//

import Foundation

class UserModel {
    static let shared = UserModel() 
    
    private let userDefaults = UserDefaults.standard
    private let userIdKey = "userIdKey"
    
    func saveUserId(_ userId: Int) {
        userDefaults.set(userId, forKey: userIdKey)
    }
    
    func getUserId() -> Int {
        return userDefaults.integer(forKey: userIdKey)
    }
}

