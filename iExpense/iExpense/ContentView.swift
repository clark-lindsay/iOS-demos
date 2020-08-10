//
//  ContentView.swift
//  iExpense
//
//  Created by Clark Lindsay on 7/9/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Tap here to dismiss this sheet") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var showingSheet = false
    @State private var hobbit: User = User(firstName: "Frodo", lastName: "Baggins")
    @State private var tapCount = UserDefaults.standard.integer(forKey: "tapCount")
    
    var body: some View {
        VStack {
            Text("Your hobbit is: \(hobbit.firstName) \(hobbit.lastName)")
            TextField("First Name", text: $hobbit.firstName)
            TextField("Last Name", text: $hobbit.lastName)
            Button("Tap count: \(tapCount)") {
                self.tapCount += 1
                UserDefaults.standard.set(self.tapCount, forKey: "tapCount")
            }
            Button("Recall hobbit from memory") {
                let decoder = JSONDecoder()
                
                if let data = try? decoder.decode(User.self, from: UserDefaults.standard.object(forKey: "hobbitData") as! Data) {
                    self.hobbit = data
                }
            }
            Button("Store hobbit data") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(self.hobbit) {
                    UserDefaults.standard.set(data, forKey: "hobbitData")
                }
            }
            Button("Show Sheet") {
                self.showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                  SecondView()
            }
        }
  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
