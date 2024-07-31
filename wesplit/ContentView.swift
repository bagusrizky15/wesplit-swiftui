//
//  ContentView.swift
//  wesplit
//
//  Created by BBPDEV on 26/07/24.
//

import SwiftUI

struct ContentView: View {
    // Binding TapCount
    //    @State var tapCount = 0
    //    var body: some View {
    //        Button("Tap Count: \(tapCount)") {
    //            self.tapCount += 1
    //        }
    //    }
    
    // Binding Form
    //    @State private var name = ""
    //    var body: some View {
    //        Form {
    //            TextField("Enter your name", text: $name)
    //            Text("Your name is \(name)")
    //        }
    //    }
    
    // Creating loop
    //    let students = ["Harry", "Potter", "Kukurukuk"]
    //    @State private var selectedStudent = "Harry"
    //
    //    var body: some View {
    //        NavigationStack {
    //            Form {
    //                Picker("Select your student", selection: $selectedStudent) {
    //                    ForEach(students, id: \.self) {
    //                        Text($0)
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    
    
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue
    }
    
    var totalAmount: Double {
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Total Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<5) {
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section {
                    Text("Total Amount: \(totalAmount.clean)")
                    Text("Total Tip: \(tipValue.clean)")
                }
                
                Section("Amount per person") {
                    Text("Rp. \(totalPerPerson.clean)")
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
        }
        }
        
    }
    
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

#Preview {
    ContentView()
}
