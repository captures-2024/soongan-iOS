//
//  BaseResponse.swift
//  NanaLand
//
//  Created by 정현우 on 4/18/24.
//

import Foundation

struct EmptyResponseModel: Codable {
    
}

struct BaseResponse<T: Codable>: Codable {
	let statusCode: Int
	let message: String
	let responseData: T?

	enum CodingKeys: String, CodingKey {
		case statusCode
		case message
		case responseData
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
		message = try container.decode(String.self, forKey: .message)
        responseData = try container.decodeIfPresent(T.self, forKey: .responseData)
	}
}
