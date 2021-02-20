//
//  ProductTableViewCell.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit
import SDWebImage

typealias ImageViewClickedHandler = () -> Void

class ProductTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var imageViewClickedHandler: ImageViewClickedHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ product: Product) {
        self.lblName.text = product.name
        self.lblPrice.text = product.price
        
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        let scrollViewWidth:CGFloat = self.scrollView.frame.size.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for index in 0..<product.image_urls_thumbnails.count {
            
            let imgView = UIImageView(frame: CGRect(x:scrollViewWidth*CGFloat((index)), y:0, width:scrollViewWidth, height:scrollViewHeight))
            let url = product.image_urls_thumbnails[0]
            imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"), options: SDWebImageOptions.continueInBackground, context: nil)
            imgView.contentMode = ContentMode.scaleAspectFit
            scrollView.addSubview(imgView)
            

            scrollView.contentSize = CGSize(width:scrollViewWidth * CGFloat(product.image_urls_thumbnails.count), height:self.scrollView.frame.height)
            scrollView.delegate = self
            pageControl.currentPage = 0
            pageControl.isHidden = product.image_urls_thumbnails.count > 1 ? false : true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let pageWidth:CGFloat = self.scrollView.frame.width
        let currentPage:CGFloat = floor((self.scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.pageControl.currentPage = Int(currentPage)
    }

}
