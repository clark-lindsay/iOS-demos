//
//  AddView.swift
//  iExpense
//
//  Created by Clark Lindsay on 8/12/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = ExpenseDomain.personal
    @State private var cost = ""
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Cost, in cents", text: $cost)
                    .keyboardType(.numberPad)
                Picker("Type", selection: $type) {
                    ForEach(ExpenseDomain.allCases, id: \.self) {
                        Text("\($0.rawValue)".capitalizingFirstLetter())
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
            }
        .navigationBarTitle("Add Expense ")
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Submit") {
                self.expenses.items.append(ExpenseItem(type: self.type, amountInCents: Int(self.cost) ?? 0, name: self.name))
                self.presentationMode.wrappedValue.dismiss()
            })
        }

    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
