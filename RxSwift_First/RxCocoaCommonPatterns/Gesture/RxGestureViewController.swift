//
//  RxGestureViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/06/01.
//

import UIKit
import RxCocoa
import RxSwift

class RxGestureViewController: UIViewController {

    @IBOutlet weak var vColor: UIView!
    
    @IBOutlet var gtPan: UIPanGestureRecognizer!
    
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        vColor.center = view.center
        
        gtPan.rx.event
            .subscribe(onNext: {
                [unowned self] gesture in
                guard let target = gesture.view else {return}
                
                let translation = gesture.translation(in: self.view)
                
                switch gesture.state {
                case .changed:
                    target.center.x += translation.x
                    target.center.y += translation.y
                case .ended:
                    UIView.animate(withDuration: 0.3) {
                        // 왼쪽 및 상단에 닿았을떄 처리
                        if target.frame.origin.x < self.view.frame.origin.x {
                            target.frame.origin.x = self.view.frame.origin.x
                        }
                        if target.frame.origin.y < self.view.frame.origin.y + self.view.safeAreaInsets.top {
                            target.frame.origin.y = self.view.frame.origin.y + self.view.safeAreaInsets.top
                        }
                        
                        // 하단 및 오른쪽에 닿았을때 처리
                        if target.frame.origin.x + target.frame.width > self.view.frame.width {
                            target.frame.origin.x = self.view.frame.width - target.frame.width
                        }
                        if target.frame.origin.y + target.frame.height > self.view.frame.height - self.view.safeAreaInsets.bottom  {
                            target.frame.origin.y = self.view.frame.height - target.frame.height - self.view.safeAreaInsets.bottom
                        }
                    }
                default:
                    break
                }
                
                gesture.setTranslation(.zero, in: self.view)
            })
            .disposed(by: bag)
    }
}
