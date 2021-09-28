//
//  ProductRepository.swift
//  AppDungMarket
//
//  Created by 임성민 on 2021/09/15.
//

import Foundation
import Alamofire

class ProductRepository {
    func fetch(onCompleted: @escaping ([ProductEntity]) -> Void) {
        let url = Secrets.URL.ProductList
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Accept-Encoding": "gzip",
            "Authorization": "Bearer \(Secrets.token)"
        ]
        
        AF.request(url, headers: headers).validate(statusCode: 200..<300).responseDecodable(of: [ProductEntity].self) { response in
            switch response.result {
            case .success:
                if let products = response.value {
                    onCompleted(products)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
