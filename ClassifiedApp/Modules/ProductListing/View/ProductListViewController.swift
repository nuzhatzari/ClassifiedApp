//
//  ConverterViewController.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit
import Foundation

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var viewLoader: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: ProductListViewToPresenterProtocol?
    let reuseIdentifier = "product_cell"
     
    var products: [Product] = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productTableView.rowHeight = UITableView.automaticDimension
        productTableView.estimatedRowHeight = UITableView.automaticDimension
        
        configureView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        productTableView.addGestureRecognizer(tap)
    }
    
    func configureView() {
        showLoading()
        presenter?.getProductList()
    }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case Segue.showDetails.rawValue:
                break
            
        @unknown default: break
            
        }
    }

    @objc func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: productTableView)
        if let indexPath = productTableView.indexPathForRow(at: point) {
            tableView(productTableView, didSelectRowAt: indexPath)
        }
        
    }
    
    //MARK: - Loader
    func showLoading() {
        viewLoader.isHidden = false
        self.view.bringSubviewToFront(viewLoader)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        viewLoader.isHidden = true
        self.view.sendSubviewToBack(viewLoader)
        activityIndicator.stopAnimating()
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDataSource & UITableViewDelegate protocol
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        
        DispatchQueue.main.async {
            cell.configureCell(product)
        }
        cell.imageViewClickedHandler = {
            self.presenter?.showDetailsOf(product: product, fromNavigationController: self.navigationController!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        presenter?.showDetailsOf(product: product, fromNavigationController: self.navigationController!)
    }

}

//MARK: - ProductListPresenterToViewProtocol
extension ProductListViewController: ProductListPresenterToViewProtocol {

    func reloadTableViewWithData(_ products: [Product]) {
        hideLoading()
        self.products = products
        self.productTableView.reloadData()
    }
    
    func noContentFromServer(_ error: Error) {
        hideLoading()
        self.products.removeAll()
        self.productTableView.reloadData()
        showAlert(with: error.localizedDescription)
    }
}
