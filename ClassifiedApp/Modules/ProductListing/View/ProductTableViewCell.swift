//
//  ProductTableViewCell.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailsImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
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
        if product.image_urls_thumbnails.count > 0 {
            let url = product.image_urls_thumbnails[0]
            self.thumbnailsImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"), options: SDWebImageOptions.continueInBackground, context: nil)
        }
    }
}
