//
//  ControlPropertyViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/06/02.
//

import UIKit
import RxCocoa
import RxSwift

class ControlPropertyViewController: UIViewController {

    let btnReset = UIBarButtonItem(title: "Reset", style: .plain, target: ControlPropertyViewController.self, action: nil)
    
    @IBOutlet weak var sdProperty: UISlider!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = btnReset
        
//        sdProperty.rx.value
//            .map { value -> UIColor in
//                return UIColor(white: CGFloat(value), alpha: 1.0)
//            }
//            .bind(to: self.view.rx.backgroundColor)
//            .disposed(by: bag)
//
//        btnReset.rx.tap
//            .map { 0.5 }
//            .bind(to: sdProperty.rx.value)
//            .disposed(by: bag)
//
//        btnReset.rx.tap
//            .map { UIColor(white: CGFloat(0.5), alpha: 1.0) }
//            .bind(to: self.view.rx.backgroundColor)
//            .disposed(by: bag)
        
        sdProperty.rx.color
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)

        btnReset.rx.tap
            .map { UIColor(white: CGFloat(0.5), alpha: 1.0) }
            .bind(to: sdProperty.rx.color.asObserver(), view.rx.backgroundColor.asObserver())
            .disposed(by: bag)
    }
}

extension Reactive where Base: UISlider {
    var color: ControlProperty<UIColor?> {
        return base.rx.controlProperty(editingEvents: .valueChanged) { slider in
            UIColor(white: CGFloat(slider.value), alpha: 1.0)
        } setter: { slider, color in
            var white = CGFloat(1)
            color?.getWhite(&white, alpha: nil)
            slider.value = Float(white)
        }

    }
}
