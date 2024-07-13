//
//  FormatFilterRow.swift
//  Everand
//

import SwiftUI

struct FormatFilterRow: View {
    var title: String
    @Binding var selected: Bool
    
    var body: some View {
        Button {
            selected.toggle()
        } label: {
            HStack{
                Text(title)
                    .font(.callout)
                Spacer()
                Image(systemName: selected ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
        .foregroundStyle(.primary)
    }
}
