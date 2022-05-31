//
//  RxNotificationViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/31.
//

import UIKit
import RxCocoa
import RxSwift

class RxNotificationViewController: UIViewController {

    let btnToggle = UIBarButtonItem(title: "Toggle", style: .plain, target: RxNotificationViewController.self, action: nil)
    
    @IBOutlet weak var tvContent: UITextView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = btnToggle
        
        
        btnToggle.rx.tap
            .subscribe(onNext: {
                [unowned self] in
                if self.tvContent.isFirstResponder {
                    self.tvContent.resignFirstResponder()
                } else {
                    self.tvContent.becomeFirstResponder()
                }
            })
            .disposed(by: bag)
        
        let willShowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardDidShowNotification)
            .map{ ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 }
            
        let willHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map{ noti in
                CGFloat(0)
            }
        
        Observable.merge(willShowObservable, willHideObservable)
            .map { [unowned self] height -> UIEdgeInsets  in
                var inset = self.tvContent.contentInset
                inset.bottom = height
                return inset
            }.subscribe(onNext:{
                [weak self] inset in
                UIView.animate(withDuration: 0.3) {
                    self?.tvContent.contentInset = inset
                }
            })
            .disposed(by: bag)
    }


}
