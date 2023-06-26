//
//  SitesViewController.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/23/23.
//

import UIKit

class SitesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //ViewModel:
    var viewModel: SitesViewModel = SitesViewModel()
    //Variables
    var sitesResponse: [SitesDeatails] = []
    var stations: [Station] = []
    var errorResponse: ErrResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params:[String:Any] = ["lat": 17.413003,
                                   "lng": 78.4264694,
                                   "radius": 500000,
                                   "orgId": 1]
        viewModel.getAlamofireResponse(parameters: params)
        
        self.activityIndicator.isHidden = true
        bindViewModel()
    }
    
    func bindViewModel() {
        
        self.activityIndicator.isHidden = false
        //For Activity Indicator
        viewModel.isLoading.bind { [weak self] isLoading in
            
            guard let self = self, let isLoading = isLoading else{
                return
            }
            DispatchQueue.main.async {
                if isLoading{
                    self.activityIndicator.startAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        //Getting Station ID
        viewModel.siteDetails.bind { [weak self] sitesResponse in
            guard let self = self, let sitesResponse = sitesResponse else{
                return
            }
            self.sitesResponse = sitesResponse
            
            for i in self.sitesResponse {
                print(i.stations)
            }
            
            print( self.sitesResponse)
        }
        
        viewModel.stations.bind { [weak self] stations in
            guard let self = self, let stations = stations else{
                return
            }
            self.stations = stations
            print(self.stations)
            for i in self.stations {
                print(i.ports!)
                for status in i.ports!{
                    if status.status == "Available"{
                        print(status.status)
                    }
                }
            }
        }
        
        viewModel.errorResponse.bind { [weak self] errorResponse in
            guard let self = self, let errorResponse = errorResponse else{
                return
            }
            self.errorResponse = errorResponse
            
            let statusCode = self.errorResponse?.status_code ?? 0
            let statusMsg = self.errorResponse?.status_message ?? ""
            
            self.displayAlertMessage(title: "Unable to Fetch Data", message: statusMsg)

        }
    }
    
    
}
