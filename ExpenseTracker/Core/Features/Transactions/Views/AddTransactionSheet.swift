//
//  AddTransactionSheet.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import SwiftUI

struct AddTransactionSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var merchant: String = ""
    @State private var amountString: String = ""
    @State private var date: Date = .now
    @State private var category: AITranscation.Category = .other
    @State private var isSubscription: Bool = false
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Mearchant", text: $merchant)
                    
                    TextField("Amount", text: $amountString)
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                    
                    Picker("Category", selection: $category) {
                        ForEach(AITranscation.Category.allCases) {cat in
                            Text(cat.displayName).tag(cat)
                        }
                    }
                    
                    Toggle("Subscription", isOn: $isSubscription)
                }
                
                Section("Notes") {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        //save transaction
                    }
                }
            }
        }
    }
}

#Preview {
    AddTransactionSheet()
}
