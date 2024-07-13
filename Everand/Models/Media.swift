//
//  Media.swift
//  Everand
//

import SwiftUI

@Observable final class Media {
    let id: Int
    let title: String
    let rating: Float
    let image: String
    let type: MediaType
    let authors: [Author]
    
    init(id: Int, title: String, rating: Float, image: String, type: MediaType, authors: [Author]) {
        self.id = id
        self.title = title
        self.authors = authors
        self.rating = rating
        self.type = type
        self.image = image
    }
}

extension Media: Identifiable {}
extension Media: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rating
        case image
        case type
        case authors
    }
    
    convenience init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(Int.self, forKey: .id)
        let title = try values.decode(String.self, forKey: .title)
        let rating = try values.decode(Float.self, forKey: .rating)
        let image = try values.decode(String.self, forKey: .image)
        let type = try values.decode(MediaType.self, forKey: .type)
        let authors = try values.decode([Author].self, forKey: .authors)
        self.init(id: id, title: title, rating: rating, image: image, type: type, authors: authors)
    }
}
