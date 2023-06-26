//
//  APICaller.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation
import Alamofire

final class APICaller{
    
    //static instance of APICaller class
    static let shareInstance = APICaller()
 
    typealias Handler<T> = (Result<T, ErrorResponseModel>) -> Void

    // Define a generic function to handle API requests
    func callAPI<T: Codable>(modelType: T.Type,url: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping Handler<T>) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: modelType) { response in
                
                debugPrint(response)
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(_):
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponseModel.self, from: response.data!)
                        completion(.failure(errorResponse))
                    } catch {
                        completion(.failure(error as! ErrorResponseModel))
                    }
                }
            }
    }
}


