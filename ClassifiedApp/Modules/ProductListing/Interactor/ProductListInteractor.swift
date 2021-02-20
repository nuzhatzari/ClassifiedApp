//
//  ConverterInteractor.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit

class ProductListInteractor: ProductListPresentorToInteractorProtocol  {
    
    var presenter: ProductListInteractorToPresenterProtocol?
    var apiDataManager: ProductListAPIDataManagerProtocol?
    
    func fetchProductList() {
        
        apiDataManager?.fetchProductsFromServer(completion: { (result: APIResult<FetchProductResponse>) in
            
            switch result {
            case .success(let json):
                if json.results != nil {
                    let result = self.parseDataFromServer(json)
                    self.presenter?.fetchedProductListSuccess(result)
                } else {
                    var defaultError: NSError?
                    if let errorMsg = json.error?.type, let code = json.error?.code {
                        defaultError = NSError(domain: "Error", code: code, userInfo: [
                            NSLocalizedDescriptionKey: NSLocalizedString(errorMsg, comment: "")
                        ])
                    }else {
                        defaultError = NSError(domain: "Error", code: 0, userInfo: [
                            NSLocalizedDescriptionKey: NSLocalizedString("Something went wrong, please try again later.", comment: "")
                        ])
                        
                    }
                    
                    self.presenter?.fetchedProductListFailed(defaultError!)
                }
                
            case .failure(let error):
                self.presenter?.fetchedProductListFailed(error)
            }
        })
    }
}

extension ProductListInteractor: ParseData {

    func parseDataFromServer(_ input: FetchProductResponse) -> [Product] {
        var products = input.results
        products?.sort {
            return $0.name.compare($1.name) == ComparisonResult.orderedAscending
        }
        return products ?? []
    }
}

struct FetchProductResponse: Decodable {
    let success: Bool?
    let results: [Product]?
    let error: APIError?
    
    /*subscript(key: String) -> Any? {
           return self.value(sforKey: key)
    }*/
}

struct APIError: Decodable {
    let code: Int
    let type: String
}

