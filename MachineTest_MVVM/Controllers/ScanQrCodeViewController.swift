//
//  ScanQrCodeViewController.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import UIKit
import SwiftQRCodeScanner

class ScanQrCodeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scanQROutlet: UIButton!
    
    //ViewModel:
    var viewModel: QRViewModel = QRViewModel()
    //Variables
    var stationID = 0
    var idFromResponse: [StationID] = []
    var errorResponse: ErrResponse? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
    }
    
    @IBAction func onScanQRBtnTapped(_ sender: UIButton) {
        
        //Simple QR Code Scanner
        let scanner = QRCodeScannerController()
        scanner.delegate =  self
        self.present(scanner, animated: true, completion: nil)
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
        viewModel.stationID.bind { [weak self] stationID in
            guard let self = self, let stationID = stationID else{
                return
            }
            self.idFromResponse = stationID
            
            for id in self.idFromResponse {
                self.displayAlertMessage(title: "success", message: "Station ID is \(id.id)")
            }
        }
        
        viewModel.errorResponse.bind { [weak self] errorResponse in
            guard let self = self, let errorResponse = errorResponse else{
                return
            }
            self.errorResponse = errorResponse
            
            let statusCode = self.errorResponse?.status_code ?? 0
            let statusMsg = self.errorResponse?.status_message ?? ""
            
            //print(statusCode)
            //print(statusMsg)
            
            self.displayAlertMessage(title: "Unable to Fetch Data", message: statusMsg)

        }
    }
    
    
    
}


extension ScanQrCodeViewController: QRScannerCodeDelegate {
    func qrScannerDidFail(_ controller: UIViewController, error: QRCodeError) {
        print("error:\(error.localizedDescription)")
    }
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("result:\(result)")
        
        let fileArray = result.components(separatedBy: "/")
                  let finalFileName = fileArray.last
                 // print("is from last url",finalFileName!)
        
        if let stationID = finalFileName {
            self.stationID = Int(stationID) ?? 0000
           // print("Station ID id \(stationID)")
            let params:[String:Any] = ["referNo":self.stationID,
                  "orgId": 1]
            viewModel.getAlamofireResponse(parameters: params)
            
            bindViewModel()
        }
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}


extension UIViewController{
    
    //Alert Controller
    public func displayAlertMessage(title:String,message:String) -> Void
     {

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
           alert.dismiss(animated: true, completion: nil)
       }))

        DispatchQueue.main.async{self.present(alert,animated: true,completion: nil)}
    }
}
