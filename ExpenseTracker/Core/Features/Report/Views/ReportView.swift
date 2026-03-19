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
    
    @Query(
        sort: \FinanceSummary.id, order: .reverse
    ) private var summaries: [FinanceSummary]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(summaries) { summary in
                        // Using a NavigationLink so the cards are interactive
                        NavigationLink(destination: SummaryDetailView(summary: summary)) {
                            SummaryCard(summary: summary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
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
                
                print("output.overview: \(output.overview) \n")
                print("output.recommendations: \(output.recommendations) \n")
                print("output.keyInsights: \(output.keyInsights) \n")
                
                context.insert(output)
                try context.save()
            } catch {
                print("Fetched Failed: \(error)")
            }
        }
    }
}

#Preview {
    ReportView()
        .modelContainer(for: FinanceSummary.self, inMemory: true)
}

// MARK: - Subviews
struct SummaryCard: View {
    let summary: FinanceSummary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // Assuming you'll add a date range to your model later
                Text(summary.createdAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption2.bold())
                    .foregroundStyle(.tertiary)
            }
            
            Text(summary.overview)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.03), radius: 8, y: 4)
        )
    }
}

struct SummaryDetailView: View {
    let summary: FinanceSummary
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header (date range placeholder)
                HStack {
                    Text("\(summary.startDate.formatted(date: .abbreviated, time: .omitted)) - \(summary.endDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                
                // Overview
                Text(summary.overview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                
                Divider()
                
                // Key Insights
                if !summary.keyInsights.isEmpty {
                    Text("Key Insights")
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(summary.keyInsights, id: \.self) { insight in
                            HStack(alignment: .top, spacing: 6) {
                                Image(systemName: "sparkles")
                                    .foregroundStyle(.purple)
                                Text(insight)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                
                // Recommendations
                if !summary.recommendations.isEmpty {
                    Text("Recommendations")
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                        .padding(.top, 8)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(summary.recommendations, id: \.self) { rec in
                            HStack(alignment: .top, spacing: 6) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                Text(rec)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .scrollIndicators(.hidden)
    }
}
