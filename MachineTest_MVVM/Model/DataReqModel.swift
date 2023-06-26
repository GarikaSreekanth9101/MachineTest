//
//  DataReqModel.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation

//MARK: QR Request Model
struct QRReqModel: Encodable {
    
    let referNo: Int
    let orgId: Int
}

//MARK: Sites ReqModel Model
struct SitesReqModel: Encodable {
    
    let orgId: Int
    let lat: Double
    let lng: Double
    let radius: Int

}
