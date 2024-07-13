//
//  FormatFilterButton.swift
//  Everand
//

import SwiftUI

struct FormatFilterButton: View {
    @Environment(\.colorScheme) var colorScheme
    var formatFilters: [MediaType]
    @Binding var showFormatFilter: Bool
    
    var buttonTitle: String {
        get {
            formatFilters.isEmpty ? "Format" : formatFilters.map { $0.string.capitalized }.joined(separator: ", ")
        }
    }
    
    var light: Color {
        get {
            colorScheme == .dark ? .white : .black
        }
    }
    
    var dark: Color {
        get {
            colorScheme == .dark ? .black : .white
        }
    }
    
    var body: some View {
        Button {
            showFormatFilter.toggle()
        } label: {
            HStack {
                Text(buttonTitle)
                Image(systemName: "chevron.down")
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .fill(formatFilters.isEmpty ? dark : light)
            .stroke(.gray, lineWidth: 1)
        )
        .foregroundStyle(formatFilters.isEmpty ? light : dark)
    }
}

extension MediaType {
    var string: String {
        switch self {
        case .ebook:
            "Ebooks"
        case .audiobook:
            "Audiobooks"
        }
    }
}
