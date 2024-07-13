//
//  Author.swift
//  Everand
//

import SwiftUI

@Observable final class Author {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Author: Identifiable {}
extension Author: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    convenience init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(Int.self, forKey: .id)
        let name = try values.decode(String.self, forKey: .name)
        
        self.init(id: id, name: name)
    }
}
