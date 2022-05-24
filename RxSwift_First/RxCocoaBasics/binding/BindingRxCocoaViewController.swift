//
//  BindingRxCocoaViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/24.
//

import UIKit
import RxSwift
import RxCocoa

class BindingRxCocoaViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var valueField: UITextField!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueLabel.text = ""
        valueField.becomeFirstResponder()
//
//        valueField.rx.text
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext:{ str in
//                self.valueLabel.text = str
//            })
//            .disposed(by: bag)
        
        valueField.rx.text
            .bind(to: self.valueLabel.rx.text)
            .disposed(by: bag)
    }


}
