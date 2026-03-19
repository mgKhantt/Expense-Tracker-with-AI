//
//  TransactionView.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import SwiftUI

struct TransactionView: View {
    
    @State private var transactions: [AITranscation] = []
    @State private var showingAdd: Bool = false
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            Group {
                if transactions.isEmpty {
                    VStack(spacing: 16) {
                        if #available(iOS 17.0, *) {
                            ContentUnavailableView(
                                "No Transactions",
                                systemImage: "tray",
                                description: Text("Add your first transaction to get started.")
                            )
                        } else {
                            VStack(spacing: 12) {
                                Image(systemName: "tray")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.6))
                                
                                Text("No Transactions")
                                    .font(.headline)
                                
                                Text("Add your first transaction to get started.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                    }
                    .padding()
                } else {
                    List {
                        ForEach(transactions) { tx in
                            TransactionRowView(tx: tx)
                        }
                        .onDelete(perform: deleteTransactions)
                    }
                }
            }
            .navigationTitle("Transactions")
            .sheet(isPresented: $showingAdd) {
                AddTransactionSheet()
                    .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .onAppear {
                loadSamples()
            }
        }
    }
}

private extension TransactionView {
    func loadSamples() {
        self.transactions = AITranscation.mockList
    }
    
    func deleteTransactions(at offset: IndexSet) {
        for index in offset {
            transactions.remove(at: index)
        }
    }
}

#Preview {
    TransactionView()
}
