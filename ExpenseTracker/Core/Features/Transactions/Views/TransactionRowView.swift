//
//  TransactionRowView.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import SwiftUI

struct TransactionRowView: View {
    let tx: AITranscation
    
    var body: some View {
        HStack {
            CategoryIcon(categroy: tx.category)
            
            VStack(alignment: .leading) {
                Text(tx.merchant)
                    .font(.headline)
                
                Text(tx.category.displayName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(tx.amount)")
                    .font(.headline)
                
                Text(tx.date.formatted())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("AITranscation Mock Preview") {
    TransactionRowView(tx: AITranscation.mock)
}
