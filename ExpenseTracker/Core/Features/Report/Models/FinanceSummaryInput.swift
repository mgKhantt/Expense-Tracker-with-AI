//
//  FinanceSummaryInput.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import Foundation

struct FinanceSummaryInput {
    let startDate: Date
    let endDate: Date
    let totalSpent: Double
    let totalsByCategory: [AITranscation.Category : Double]
    let flaggedCategories: [AITranscation.Category : Double]
    let topMerchants: [String : Double]
    
    init(startDate: Date, endDate: Date, totalSpent: Double, totalsByCategory: [AITranscation.Category : Double], flaggedCategories: [AITranscation.Category : Double], topMerchants: [String : Double]) {
        self.startDate = startDate
        self.endDate = endDate
        self.totalSpent = totalSpent
        self.totalsByCategory = totalsByCategory
        self.flaggedCategories = flaggedCategories
        self.topMerchants = topMerchants
    }
    
    init(from transactions: [AITranscation]) {
        var categoryTotals: [AITranscation.Category : Double] = [:]
        var merchantTotals: [String : Double] = [:]
        var spentAccumulator: Double = 0
        
        if let minDate = transactions.map({$0.date}).min(), let maxDate = transactions.map({$0.date}).max() {
            self.startDate = minDate
            self.endDate = maxDate
        } else {
            let now = Date()
            self.startDate = now
            self.endDate = now
        }
        
        for tx in transactions {
            let amount = tx.amount
            
            spentAccumulator += amount
            categoryTotals[tx.category, default: 0] += amount
            
            let merchant = tx.merchant
            merchantTotals[merchant, default: 0] += amount
        }
        
        self.totalSpent = spentAccumulator
        self.totalsByCategory = categoryTotals
        self.topMerchants = merchantTotals
        
        let catValues = Array(categoryTotals.values)
        let avg = (catValues.reduce(0, +) / Double(catValues.count))
        
        self.flaggedCategories = categoryTotals.filter { $0.value > avg }
    }
}
extension FinanceSummaryInput {
    
    static var mockCurrentWeek: FinanceSummaryInput {
        let calendar = Calendar.current
        let now = Date()
        
        let weekComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)
        let startOfWeek = calendar.date(from: weekComponents) ?? now
        
        let endofWeekBase = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? now
        let endOfWeek = calendar.startOfDay(for: endofWeekBase)
        
        let totalsByCategory: [AITranscation.Category : Double] = [
            .groceries: 124.83,
            .dining: 45.23,
            .entertainment: 32.12,
            .transport: 12.34,
            .utilities: 45.67,
        ]
        
        let flaggedCategories: [AITranscation.Category : Double] = [
            .groceries: 12.34,
            .dining: 5.67,
        ]
        
        let topMerchants: [String : Double] = [
            "KFC": 34.56,
            "Subway": 23.45,
        ]
        
        let totalSpent = totalsByCategory.values.reduce(0, +)
        
        return FinanceSummaryInput(
            startDate: startOfWeek,
            endDate: endOfWeek,
            totalSpent: totalSpent,
            totalsByCategory: totalsByCategory,
            flaggedCategories: flaggedCategories,
            topMerchants: topMerchants
        )
    }
}

