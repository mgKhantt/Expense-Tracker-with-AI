//
//  FinanceSummary.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import Foundation
import SwiftData

@Model
class FinanceSummary: Identifiable {
    var id: UUID = UUID()
    var startDate: Date
    var endDate: Date
    var overview: String
    var keyInsights: [String]
    var recommendations: [String]
    var createdAt: Date = Date()
    
    init(startDate: Date,endDate: Date, overview: String, keyInsights: [String], recommendations: [String]) {
        self.startDate = startDate
        self.endDate = endDate
        self.overview = overview
        self.keyInsights = keyInsights
        self.recommendations = recommendations
    }
}
