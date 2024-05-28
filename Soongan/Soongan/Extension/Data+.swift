//
//  Data+.swift
//  Soongan
//
//  Created by jun on 5/28/24.
//

import Foundation

import Foundation
import Alamofire

extension Foundation.Data {
    func decode<Item: Decodable, Decoder: DataDecoder>(type: Item.Type, decoder: Decoder = JSONDecoder()) throws -> Item {
        try decoder.decode(type, from: self)
    }
}
