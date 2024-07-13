//
//  MediaRowView.swift
//  Everand
//

import SwiftUI

struct MediaRowView: View {
    @State var media: Media
    
    var body: some View {
        HStack(alignment: .top) {
            Image(media.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 124)
                .border(.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .padding(.trailing, 8)
            VStack(alignment: .leading, spacing: 8) {
                Text(media.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(media.authors.map { $0.name }.joined(separator: ", "))
                    .font(.subheadline)
                RatingView(rating: media.rating)
            }
            Spacer()
            Image(systemName: "bookmark")
        }
    }
}
