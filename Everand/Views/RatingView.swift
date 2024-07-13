//
//  RatingView.swift
//  Everand
//

import SwiftUI

struct RatingView: View {
    @State var rating: Float
    var size: CGFloat = 16
    
    var fullStar: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: size, height: size)
    }

    var halfStar: some View {
        Image(systemName: "star.leadinghalf.fill")
            .resizable()
            .frame(width: size, height: size)
    }

    var emptyStar: some View {
        Image(systemName: "star")
            .resizable()
            .frame(width: size, height: size)
    }
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<Int(rating), id: \.self) { _ in
                fullStar
            }

            if (rating != floor(rating)) {
                halfStar
            }

            ForEach(0..<Int(5 - rating), id: \.self) { _ in
                emptyStar
            }
        }
    }
}
