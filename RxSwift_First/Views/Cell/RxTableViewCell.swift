//
//  TableViewCell.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/23.
//

import UIKit

class RxTableViewCell: UITableViewCell {

    static let identify = "RxTableViewCell"
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(data:RxListModel) {
        lbTitle.text = data.strTitle
    }
}
