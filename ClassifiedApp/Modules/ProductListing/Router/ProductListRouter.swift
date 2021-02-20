//
//  ConverterRouter.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit

class ProductListRouter: ProductListPresenterToRouterProtocol {

    var presenter: ProductListPresenter?
    static func createModule() -> ProductListViewController {
        let view = Utility.mainstoryboard().instantiateViewController(withIdentifier: StoryboardID.productList.rawValue) as! ProductListViewController
        
        let presenter = ProductListPresenter()
        let interactor = ProductListInteractor()
        let router = ProductListRouter()
        let apiDataManager = ProductListAPIDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        
        return view
    }

    func navigateToShowProduct(details: Product, fromNavigationController navigationController: UINavigationController) {
        
        let view = Utility.mainstoryboard().instantiateViewController(withIdentifier: StoryboardID.productDetails.rawValue) as! ProductDetailsViewController
        view.productName(details.name, price: details.price, thumbnails: details.image_urls_thumbnails, fullImages: details.image_urls)
        navigationController.pushViewController(view, animated: true)
    }

}
