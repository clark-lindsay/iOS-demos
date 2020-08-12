//
//  ExpenseList.swift
//  iExpense
//
//  Created by Clark Lindsay on 8/11/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(self.items) {
                UserDefaults.standard.set(data, forKey: "expenses")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "expenses") {
            if let expenses = try? decoder.decode([ExpenseItem].self, from: data) {
                self.items = expenses
                return
            }
        }
        self.items = []
    }
}
