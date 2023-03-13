//
//  CustomBinderViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/06/01.
//

import UIKit
import RxSwift
import RxCocoa


class CustomBinderViewController: UIViewController {
    
    @IBOutlet weak var lbColor: UILabel!
    
    @IBOutlet weak var sgColor: UISegmentedControl!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        sgColor.rx.selectedSegmentIndex
//            .map {
//                index -> UIColor in
//                switch index {
//                case 0:
//                    return UIColor.red
//                case 1:
//                    return UIColor.green
//                case 2:
//                    return UIColor.blue
//                default:
//                    return UIColor.black
//                }
//            }
//            .bind(to: lbColor.rx.textColor)
//            .disposed(by: bag)
//
//        sgColor.rx.selectedSegmentIndex
//            .map {
//                index -> String? in
//                switch index {
//                case 0:
//                    return "Red"
//                case 1: 
//                    return "Green"
//                case 2:
//                    return "Blue"
//                default:
//                    return "Black"
//                }
//            }
//            .bind(to: lbColor.rx.text)
//            .disposed(by: bag)
        sgColor.rx.selectedSegmentIndex
            .bind(to: lbColor.rx.segmentedValue)
            .disposed(by: bag)
    }
}

extension Reactive where Base:UILabel {
    var segmentedValue: Binder<Int> {
        return Binder(self.base) {
            label, index in
            switch index {
            case 0:
                label.text = "Red"
                label.textColor = UIColor.red
            case 1:
                label.text = "Green"
                label.textColor = UIColor.green
            case 2:
                label.text = "Blue"
                label.textColor = UIColor.blue
            default:
                label.text = "Black"
                label.textColor = UIColor.black
            }
        }
    }
}
