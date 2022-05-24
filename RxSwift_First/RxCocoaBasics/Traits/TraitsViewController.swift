//
//  TraitsViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/24.
//

import UIKit
import RxSwift
import RxCocoa


class TraitsViewController: UIViewController {
    let bag = DisposeBag()

    @IBOutlet weak var vColor: UIView!
    
    @IBOutlet weak var sdRed: UISlider!
    @IBOutlet weak var sdGreen: UISlider!
    @IBOutlet weak var sdBlue: UISlider!
    
    @IBOutlet weak var lbRed: UILabel!
    @IBOutlet weak var lbGreen: UILabel!
    @IBOutlet weak var lbBlue: UILabel!
    
    @IBOutlet weak var btnReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sdRed.rx.value
            .map{"\(Int($0))"}
            .bind(to: lbRed.rx.text)
            .disposed(by: bag)
        
        sdGreen.rx.value
            .map{"\(Int($0))"}
            .bind(to: lbGreen.rx.text)
            .disposed(by: bag)
        
        sdBlue.rx.value
            .map{"\(Int($0))"}
            .bind(to: lbBlue.rx.text)
            .disposed(by: bag)
//
//        Observable.combineLatest([sdRed.rx.value, sdGreen.rx.value, sdBlue.rx.value])
//            .map {
//                UIColor(red: CGFloat($0[0]/255), green: CGFloat($0[1]/255), blue: CGFloat($0[2]/255), alpha: 1.0)
//            }
//            .bind(to:vColor.rx.backgroundColor)
        
        let comSdColors = Observable.combineLatest([sdRed.rx.value, sdGreen.rx.value, sdBlue.rx.value])
        
        comSdColors.map {
            UIColor(red: CGFloat($0[0]/255), green: CGFloat($0[1]/255), blue: CGFloat($0[2]/255), alpha: 1.0)
        }.bind(to: vColor.rx.backgroundColor)
            .disposed(by: bag)
        
        btnReset.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                self.vColor.backgroundColor = UIColor.black
                self.sdRed.value = 0
                self.sdGreen.value = 0
                self.sdBlue.value = 0
                
                self.lbRed.text = "0"
                self.lbGreen.text = "0"
                self.lbBlue.text = "0"
            })
            .disposed(by: bag)
    }

}
