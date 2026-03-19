//
//  FinanceSummarizer.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import Foundation
import FoundationModels

struct FinanceSummarizer {
    let session = LanguageModelSession {
        """
            You are a finacen advisor.
            You will receive input data about a users finacial transctions and are asked with generating a finicial summary.
            Here is an example input: \(FinanceSummaryInput.mockCurrentWeek)
            Here is an example output: \(FinanceSummaryOutput.mock)
        """
    }
    
    func summarize(_ input: FinanceSummaryInput) async throws -> FinanceSummaryOutput {
        let prompt = """
            Analyze the user's weekly finicial data below and produce a concise, firendly summary.
            -Include a title
            -Write a 2-3 sentence overivew of spending
            -List 3-5 key insights about trends or categories
            -Suggest 2-3 actionable recommendations to save money
            
            Data: 
            Total spent: \(input.totalSpent)
            Categories: \(input.totalsByCategory.map {"\($0.key.displayName): \($0.value)"}.joined(separator: ", "))
            Flagged categories: \(input.flaggedCategories.map {"\($0.key.displayName): \($0.value)"}.joined(separator: ", "))
            Top merchants: \(input.topMerchants.map {"\($0.key): \($0.value)"}.joined(separator: ", "))
            Date range: \(input.startDate.formatted(date: .abbreviated, time: .omitted)) - \(input.endDate.formatted(date: .abbreviated, time: .omitted))
            """
        
        let output = try await session.respond(to: prompt, generating: FinanceSummaryOutput.self)
        print("DEBUG: Output Content: \(output.content)")
        
        return output.content
    }
}
