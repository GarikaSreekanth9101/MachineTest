//
//  SitesResponseModel.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation


// MARK: - SitesResponseModel
struct SitesResponseModel: Codable {
    let data: [SitesDeatails]
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

// MARK: - SitesDeatails
struct SitesDeatails: Codable {
    let id: Int
    let name, latitude, longitude, distanceUnit: String
    let distance: Double
    let logo, address: String
    let stations: [Station]
}

// MARK: - Station
struct Station: Codable {
    let ports: [Port]?
}

// MARK: - Port
struct Port: Codable {
    let status: String
}

