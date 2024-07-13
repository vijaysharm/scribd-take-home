//
//  ContentView.swift
//  Everand
//

import SwiftUI

@Observable
class ViewModel {
    public var showFormatFilter: Bool = false
    public var formatFilters: [MediaType] = []
    public var media: [Media] {
        get {
            if formatFilters.isEmpty {
                return data
            }
            return data.filter { formatFilters.contains($0.type) }
        }
    }
    
    private var data: [Media] = []
    
    public func loadMedia() async {
        guard let url = Bundle.main.url(forResource: "media", withExtension: "json") else {
            fatalError("Failed to load mock file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read mock data")
        }
        
        guard let data = try? JSONDecoder().decode([Media].self, from: data) else {
            fatalError("Failed to decode mock data")
        }
        
        self.data = data
    }
}

struct ContentView: View {
    @Bindable var model: ViewModel

    var body: some View {
        ZStack {
            MediaView(
                media: model.media,
                formatFilters: model.formatFilters,
                showFormatFilter: $model.showFormatFilter
            )
            FormatFilterView(
                current: model.formatFilters,
                isShowing: $model.showFormatFilter
            ) {
                print("Updating filters: \($0)")
                model.formatFilters = $0
            }
        }
        .task {
            await model.loadMedia()
        }
    }
}

#Preview {
    ContentView(model: ViewModel())
}
