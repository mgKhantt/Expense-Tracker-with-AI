//
//  CategoryIcon.swift
//  ExpenseTracker
//
//  Created by Khant Phone Naing  on 19/03/2026.
//

import SwiftUI

struct CategoryIcon: View {
    let categroy: AITranscation.Category
    
    var body: some View {
        let info = categroy.iconInfo
        
        Image(systemName: info.symbol)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 32, height: 32)
            .background(
                Circle()
                    .fill(info.color.gradient)
            )
            .accessibilityHidden(true)
    }
}

#Preview {
    CategoryIcon(categroy: .dining)
}
