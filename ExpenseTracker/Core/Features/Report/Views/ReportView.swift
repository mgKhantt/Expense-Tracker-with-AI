//
//  ReportView.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import SwiftUI
import SwiftData

struct ReportView: View {
    @Environment(\.modelContext) private var context
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Reports")
            .toolbar {
                Button {
                    generateWeeklyReport()
                } label: {
                    if isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: "sparkles")
                    }
                }
            }
        }
    }
}

private extension ReportView {
    func generateWeeklyReport() {
        guard !isLoading else { return }
        
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                let descriptor = FetchDescriptor<AITranscation>()
                let transactions = try context.fetch(descriptor)
                let input = FinanceSummaryInput(from: transactions)
                
                let output = try await FinanceSummarizer().summarize(input)
                
                print(output.overview)
                print(output.recommendations)
                print(output.keyInsights)
            } catch {
                print("Fetched Failed: \(error)")
            }
        }
    }
}

#Preview {
    ReportView()
}
