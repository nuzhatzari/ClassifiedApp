//
//  ConverterProtocols.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit

protocol ProductListViewToPresenterProtocol: class {
    
    var view: ProductListPresenterToViewProtocol? { get set }
    var interactor: ProductListPresentorToInteractorProtocol? { get set }
    var router: ProductListPresenterToRouterProtocol? {get set}
    
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getProductList()
    func showDetailsOf(product: Product, fromNavigationController navigationController: UINavigationController)
}

protocol ProductListPresenterToViewProtocol: class {
    
    //PRESENTER
    var presenter: ProductListViewToPresenterProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func reloadTableViewWithData(_ products: [Product])
    func noContentFromServer(_ error: Error)
}

protocol ProductListPresentorToInteractorProtocol: class {
    var presenter: ProductListInteractorToPresenterProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func fetchProductList()
}

protocol ProductListInteractorToPresenterProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR  -> PRESENTER
    */
    func fetchedProductListSuccess(_ convertedCurrency:[Product])
    func fetchedProductListFailed(_ error: Error)
}

protocol ProductListPresenterToRouterProtocol: class {
    static func createModule()-> ProductListViewController
    func navigateToShowProduct(details: Product, fromNavigationController navigationController: UINavigationController)
    
}

protocol ProductListAPIDataManagerProtocol {
    func fetchProductsFromServer(completion: @escaping ((APIResult<FetchProductResponse>) -> Void))
}
