//
//  FormatFilterView.swift
//  Everand
//

import SwiftUI

struct FormatFilterView: View {
    @Observable class ViewModel {
        public var current: [MediaType] = []
        
        init(current: [MediaType]) {
            self.current = current
        }
        
        var ebook: Binding<Bool> {
            Binding {
                self.current.contains(.ebook)
            } set: { newValue in
                if newValue {
                    self.current.append(.ebook)
                } else {
                    self.current = self.current.filter { $0 != .ebook }
                }
            }
        }
        
        var audiobook: Binding<Bool> {
            Binding {
                self.current.contains(.audiobook)
            } set: { newValue in
                if newValue {
                    self.current.append(.audiobook)
                } else {
                    self.current = self.current.filter { $0 != .audiobook }
                }
            }
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    var isShowing: Binding<Bool>
    var action: ([MediaType]) -> Void
    private var model: ViewModel
    
    init(current: [MediaType], isShowing: Binding<Bool>, action: @escaping ([MediaType]) -> Void) {
        self.isShowing = isShowing
        self.action = action
        self.model = ViewModel(current: current)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing.wrappedValue {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing.wrappedValue = false
                        }
                    }
                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Formats")
                            }
                            Button {
                                model.current.removeAll()
                            } label: {
                                Text("Clear All")
                                    .foregroundStyle(.gray)
                                    .font(.caption2)
                            }
                        }
                        if model.current.count > 0 {
                            Text("\(model.current.count)")
                                .font(.caption2)
                                .padding(6)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .background(colorScheme == .dark ? .white : .black)
                                .clipShape(Circle())
                        }
                        Spacer()
                        Button {
                            isShowing.wrappedValue = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .tint(.primary.opacity(0.3))
                        }
                    }
                    FormatFilterRow(title: "Ebooks", selected: model.ebook)
                    FormatFilterRow(title: "Audiobooks", selected: model.audiobook)
                    Button {
                        isShowing.wrappedValue = false
                        action(model.current)
                    } label: {
                        Text("Apply")
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .background(colorScheme == .dark ? .white : .black)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
                .padding(24)
                .padding(.bottom, 36)
                .frame(maxWidth: .infinity)
                .background(.background)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing.wrappedValue)
    }
}
