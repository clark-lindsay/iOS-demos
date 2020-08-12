//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Clark Lindsay on 8/11/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var type: ExpenseDomain;
    var amountInCents: Int
    var name: String
}

enum ExpenseDomain: String, CaseIterable, Codable {
    case business, personal
}
