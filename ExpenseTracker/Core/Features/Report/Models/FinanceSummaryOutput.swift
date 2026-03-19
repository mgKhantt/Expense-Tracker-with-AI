//
//  FinanceSummaryOutput.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import Foundation
import FoundationModels

@Generable
struct FinanceSummaryOutput {
    @Guide(description: "An overview of the finance summary output.")
    var overview: String
    
    @Guide(description: "3-5 bullets highlighting trends, spikes, or category/merchant insights.")
    var keyInsights: [String]
    
    @Guide(description: "2-3 specific, partial recommendation tied to the week's data.")
    var recommendations: [String]
}

extension FinanceSummaryOutput {
    static var mock: FinanceSummaryOutput {
        FinanceSummaryOutput(
            overview: "Your financial activity this month shows a balanced spending pattern with a slight increase in discretionary expenses. Income remains stable, while savings growth is moderate.",
            
            keyInsights: [
                "Spending on dining and entertainment increased by 18% compared to last month.",
                "Essential expenses such as rent and utilities remain consistent.",
                "Savings rate is approximately 22% of total income.",
                "No unusual or unexpected transactions detected."
            ],
            
            recommendations: [
                "Consider reducing dining expenses to improve monthly savings.",
                "Set a fixed budget for entertainment categories.",
                "Allocate at least 25–30% of income towards savings for better financial stability.",
                "Track small recurring expenses to identify potential cost leaks."
            ]
        )
    }
}
