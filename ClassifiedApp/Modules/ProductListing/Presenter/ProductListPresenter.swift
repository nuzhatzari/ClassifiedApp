//
//  ConverterPresenter.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit

class ProductListPresenter: ProductListViewToPresenterProtocol {
    var view: ProductListPresenterToViewProtocol?
    var interactor: ProductListPresentorToInteractorProtocol?
    var router: ProductListPresenterToRouterProtocol?
    
    func getProductList() {
        interactor?.fetchProductList()
    }
    
    func showDetailsOf(product: Product, fromNavigationController navigationController: UINavigationController) {
        router?.navigateToShowProduct(details: product, fromNavigationController: navigationController)
    }
}

extension ProductListPresenter: ProductListInteractorToPresenterProtocol {
    func fetchedProductListSuccess(_ productList: [Product]) {
        view?.reloadTableViewWithData(productList)
    }
    
    func fetchedProductListFailed(_ error: Error) {
        view?.noContentFromServer(error)
    }
}
