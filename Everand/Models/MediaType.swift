//
//  MediaType.swift
//  Everand
//

import Foundation

enum MediaType {
    case ebook
    case audiobook
}

extension MediaType: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try container.decode(String.self)
        
        if "ebook" == status {
            self = .ebook
        } else if "audiobook" == status {
            self = .audiobook
        } else {
            fatalError("Failed to find suitable media type \(status)")
        }
    }
}
