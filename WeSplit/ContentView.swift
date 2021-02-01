//
//  ContentView.swift
//  WeSplit
//
//  Created by Travis Brigman on 1/29/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
//    @State private var useRedText = false
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numberOfPeople) ?? 0 + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    var noTip: Bool {
        let orderAmount = Double(checkAmount) ?? 0
       return grandTotal == orderAmount
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number Of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                    }
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip Percentages", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section{
                    Text("Check Total $\(grandTotal, specifier: "%.2F")")
                        .foregroundColor(noTip ? .red : .none)
                }
                
                Section(header:Text("Amount Per Person")){
                    Text("$\(totalPerPerson, specifier: "%.2F")")
                    
                }
            }
            
            .navigationBarTitle("WeSplit")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
