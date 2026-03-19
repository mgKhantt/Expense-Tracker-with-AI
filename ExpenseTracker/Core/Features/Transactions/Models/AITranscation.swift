//
//  AITranscation.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class AITranscation: Identifiable {
    var id: UUID
    var amount: Double
    var date: Date
    var merchant: String
    var category: Category
    var isSubscription: Bool
    var notes: String?
    
    init(id: UUID, amount: Double, date: Date, merchant: String, category: Category, isSubscription: Bool, notes: String? = nil) {
        self.id = id
        self.amount = amount
        self.date = date
        self.merchant = merchant
        self.category = category
        self.isSubscription = isSubscription
        self.notes = notes
    }
    
    enum Category: String, Codable, CaseIterable, Identifiable {
        case groceries
        case dining
        case transport
        case shopping
        case entertainment
        case utilities
        case health
        case travel
        case subscriptions
        case other
        
        var id: String { rawValue }
        
        var displayName: String {
            switch self {
                case .groceries:
                    return "Groceries"
                case .dining:
                    return "Dining"
                case .transport:
                    return "Transport"
                case .shopping:
                    return "Shopping"
                case .entertainment:
                    return "Entertainment"
                case .utilities:
                    return "Utilities"
                case .health:
                    return "Health"
                case .travel:
                    return "Travel"
                case .subscriptions:
                    return "Subscriptions"
                case .other:
                    return "Other"
            }
        }
        
        var iconInfo: (symbol: String, color: Color) {
            switch self {
                case .groceries:
                    return ("cart.fill", .green)
                case .dining:
                    return ("fork.knife.circle", .orange)
                case .transport:
                    return ("car.fill", .blue)
                case .shopping:
                    return ("bag.fill", .pink)
                case .entertainment:
                    return ("film.fill", .purple)
                case .utilities:
                    return ("bolt.fill", .yellow)
                case .health:
                    return ("heart.fill", .red)
                case .travel:
                    return ("airplane", .teal)
                case .subscriptions:
                    return ("repeat.circle.fill", .indigo)
                case .other:
                    return ("ellipsis.circle.fill", .gray)
            }
        }
    }
    
    static func make(
        id: UUID = UUID(),
        amount: Double,
        daysAgo: Int = 0,
        merchant: String,
        category: Category,
        isSubscription: Bool = false,
        notes: String? = nil
    ) -> AITranscation {
        AITranscation(
            id: id,
            amount: amount,
            date: Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date(),
            merchant: merchant,
            category: category,
            isSubscription: isSubscription,
            notes: notes
        )
    }
    
    static var mock: AITranscation {
        .make(
            amount: 12.49,
            daysAgo: 1,
            merchant: "Starbucks",
            category: .dining,
            notes: "Latte and croissant"
        )
    }
    
    static var mockList: [AITranscation] {
        [
            .make(
                amount: 12.49,
                daysAgo: 1,
                merchant: "Starbucks",
                category: .dining,
                notes: "Latte and croissant"
            ),
            .make(
                amount: 78.32,
                daysAgo: 2,
                merchant: "Whole Foods",
                category: .groceries,
                notes: "Weekly groceries"
            ),
            .make(
                amount: 9.99,
                daysAgo: 10,
                merchant: "Netflix",
                category: .subscriptions,
                isSubscription: true,
                notes: "Monthly subscription"
            ),
            .make(
                amount: 23.50,
                daysAgo: 3,
                merchant: "Uber",
                category: .transport,
                notes: "Airport ride"
            ),
            .make(
                amount: 145.00,
                daysAgo: 15,
                merchant: "Apple Store",
                category: .shopping,
                notes: "Accessories"
            ),
            .make(
                amount: 59.00,
                daysAgo: 5,
                merchant: "City Utilities",
                category: .utilities,
                notes: "Electric bill"
            ),
            .make(
                amount: 34.75,
                daysAgo: 4,
                merchant: "AMC Theatres",
                category: .entertainment,
                notes: "Movie night"
            ),
            .make(
                amount: 26.20,
                daysAgo: 7,
                merchant: "CVS Pharmacy",
                category: .health,
                notes: "Vitamins and supplies"
            ),
            .make(
                amount: 420.00,
                daysAgo: 20,
                merchant: "Delta",
                category: .travel,
                notes: "Flight to SFO"
            ),
            .make(
                amount: 4.29,
                daysAgo: 0,
                merchant: "7-Eleven",
                category: .other,
                notes: "Bottled water"
            )
        ]
    }
}

