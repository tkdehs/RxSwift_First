//
//  HelloRxCocoaViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class HelloRxCocoaViewController: UIViewController {

    let bag = DisposeBag()
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var tabButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabButton.rx.tap
            .map { "Hello, RxCocoa" }
//            .subscribe(onNext: { [weak self] str in
//                self?.valueLabel.text = str
//
//            })
            .bind(to: valueLabel.rx.text)
            .disposed(by: bag)

    }


}
