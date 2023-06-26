//
//  SitesViewModel.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/23/23.
//

import Foundation
import Alamofire

class SitesViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var response: SitesResponseModel?
    var errorDataSource: ErrorResponseModel?
    var siteDetails: Observable<[SitesDeatails]> = Observable(nil)
    var stations: Observable<[Station]> = Observable(nil)
    var errorResponse: Observable<ErrResponse> = Observable(nil)
    
    func getAlamofireResponse(parameters: [String: Any]?){
        
        let apiUrl = "https://portal-3-stg.evgateway.com:8200/api/v3/info/sites"
        let headers = HTTPHeaders([
            "EVG-Correlation-ID": "c3b3812b-72b1-4ca5-b340-8f5924d6e3a1"
        ])
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.shareInstance.callAPI(modelType: SitesResponseModel.self,url: apiUrl, method: .get, parameters: parameters, headers: headers) { [weak self] result in
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
        self.siteDetails.value = self.response?.data
        for stations in self.response!.data{
            self.stations.value = stations.stations
        }
    }
}
