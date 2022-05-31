//
//  ColorCell.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/27.
//

import UIKit

class ColorCell: UICollectionViewCell {
    static let id = "ColorCell"
    
    
    @IBOutlet weak var lbColor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbColor.text = ""
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lbColor.text = ""
    }
}
