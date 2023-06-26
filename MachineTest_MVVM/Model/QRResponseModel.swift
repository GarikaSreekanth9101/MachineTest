//
//  QRResponseModel.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation
// MARK: - QRResponseModel
struct QRResponseModel: Codable {
    let data: [StationID]
    let statusCode: Int
    let statusMessage: String
    let timestamp: String

    enum CodingKeys: String, CodingKey {
        case data
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case timestamp = "timestamp"
    }
}

// MARK: - StationID
struct StationID: Codable {
    let id: Int
}
