//
//  ConverterAPIDataManager.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit

class ProductListAPIDataManager: ProductListAPIDataManagerProtocol, NetworkManager {
    init() {}
    
    func fetchProductsFromServer(completion: @escaping ((APIResult<FetchProductResponse>) -> Void)) {
        
        fetchData(completion: {(result: APIResult<FetchProductResponse>) in
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
}
