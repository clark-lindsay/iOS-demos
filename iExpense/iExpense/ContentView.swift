//
//  ContentView.swift
//  iExpense
//
//  Created by Clark Lindsay on 7/9/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpenseView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    ExpenseView(expense: item)
                }
            .onDelete(perform: removeItems)
            }
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpenseView = true
                }) {
                    Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddExpenseView) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExpenseView: View {
    @State var expense: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(expense.name)")
                    .font(.headline)
                Text("\(expense.type.rawValue)")
                    .font(.subheadline)
            }
            Spacer()
            Text("$\(Double(expense.amountInCents) / 100)")
        }
    }
}
