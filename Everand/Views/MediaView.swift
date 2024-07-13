//
//  MediaView.swift
//  Everand
//

import SwiftUI

struct MediaView: View {
    var media: [Media]
    var formatFilters: [MediaType]
    @Binding var showFormatFilter: Bool
    
    var indexItems: [(index: Int, media: Media)] {
        get {
            media.enumerated().map { element in
                (index: element.offset + 1, media: element.element)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                FormatFilterButton(
                    formatFilters: formatFilters,
                    showFormatFilter: $showFormatFilter
                )
                Spacer()
            }
            List {
                ForEach(indexItems, id: \.media.id) { item in
                    HStack(alignment: .top) {
                        Text("\(item.index).")
                        MediaRowView(media: item.media)
                            .listRowSeparator(.hidden)
                    }
                }
            }.listStyle(.plain)
        }
    }
}
