//
//  ProductCell.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/26.
//

import UIKit

class ProductCell: UITableViewCell {
    static let id = "ProductCell"

    @IBOutlet weak var lbCategory: UILabel!
    
    @IBOutlet weak var lbProduct: UILabel!
    
    @IBOutlet weak var lbSummary: UILabel!
    
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
