//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TransactionView()
                .tabItem {
                    Label("Transactions", systemImage: "creditcard.fill")
                }
            
            ReportView()
                .tabItem {
                    Label("Reports", systemImage: "doc.text.magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}
