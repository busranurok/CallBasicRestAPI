//
//  ProductTableViewCell.swift
//  Product
//
//  Created by Yeni Kullanıcı on 17.10.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
