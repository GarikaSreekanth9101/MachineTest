//
//  ErrorResponseModel.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation
// MARK: - ErrorResponseModel
struct ErrorResponseModel: Codable,Error {
    let response: ErrResponse
}

// MARK: - Response
struct ErrResponse: Codable {
    let timestamp: String
    let status_code: Int
    let status_message: String
    let data: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
