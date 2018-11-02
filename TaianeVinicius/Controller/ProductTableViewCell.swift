//
//  ProductTableViewCell.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 01/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with product: Product) {
        lbName.text = product.name
        lbPrice.text = "US$ \(product.price)"
        
        if let image = product.image as? UIImage {
            ivImage.image = image
        } else {
            ivImage.image = UIImage(named: "image-placeholder")
        }
    }

}
