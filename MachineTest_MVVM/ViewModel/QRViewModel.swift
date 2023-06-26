//
//  QRViewModel.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation
import Alamofire

class QRViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var response: QRResponseModel?
    var errorDataSource: ErrorResponseModel?
    var stationID: Observable<[StationID]> = Observable(nil)
    var errorResponse: Observable<ErrResponse> = Observable(nil)
    
    func getResponse(params: QRReqModel) {
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
    }
    
    func getAlamofireResponse(parameters: [String: Any]?){
        
        let apiUrl = "https://mobileapi.evgateway.com/api/v3/info/stationIdFromReferNo"
        let headers = HTTPHeaders([
            "EVG-Correlation-ID": "c3b3812b-72b1-4ca5-b340-8f5924d6e3a1"
        ])
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.shareInstance.callAPI(modelType: QRResponseModel.self,url: apiUrl, method: .get, parameters: parameters, headers: headers) { [weak self] result in
            debugPrint(result)
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                self?.response = data
                self?.mapCellData()
            case .failure(let error):
                self?.errorDataSource = error
                self?.errorResponse.value = self?.errorDataSource?.response
            }
        }
        
    }
    func mapCellData(){
        self.stationID.value = self.response?.data
    }
}
