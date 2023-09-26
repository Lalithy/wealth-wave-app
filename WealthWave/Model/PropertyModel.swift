//
//  UserModel.swift
//  WealthWave
//
//  Created by Lali.. on 24/09/2023.
//

import Foundation

class PropertyModel {
    static let shared = PropertyModel()
    
    private let userDefaults = UserDefaults.standard
    private let userIdKey = "userIdKey"
    private let budgetCategoryIdKey = "budgetCategoryIdKey"

    
    func saveUserId(_ userId: Int) {
        userDefaults.set(userId, forKey: userIdKey)
    }
    
    func getUserId() -> Int {
        return userDefaults.integer(forKey: userIdKey)
    }
    
    func saveCategoryId(_ budgetCategoryId: Int) {
        userDefaults.set(budgetCategoryId, forKey: budgetCategoryIdKey)
    }
    
    func getCategoryId() -> Int {
        return userDefaults.integer(forKey: budgetCategoryIdKey)
    }
    
   
}

