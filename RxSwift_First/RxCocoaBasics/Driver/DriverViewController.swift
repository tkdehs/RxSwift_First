//
//  DriverViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/24.
//

import UIKit
import RxSwift
import RxCocoa

class DriverViewController: UIViewController {

    @IBOutlet weak var tfInput: UITextField!
    
    @IBOutlet weak var lbVisible: UILabel!
    
    @IBOutlet weak var btnSend: UIButton!
    
    enum ValidationError : Error {
        case notANumber
    }
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       드라이버 미사용
//        let result = tfInput.rx.text
//            .flatMapLatest{
//                self.validateText($0)
//                    .observe(on: MainScheduler.instance)
//                    .catchAndReturn(false)
//
//            }
//            .share()
//
//        result
//            .map { $0 ? "Ok" : "Error" }
//            .bind(to: lbVisible.rx.text)
//            .disposed(by: bag)
//
//        result
//            .map{ $0 ? UIColor.blue : UIColor.red }
//            .bind(to: lbVisible.rx.backgroundColor)
//            .disposed(by: bag)
//
//        result.bind(to: btnSend.rx.isEnabled)
//            .disposed(by: bag)
        
//       드라이버 사용
        let result = tfInput.rx.text.asDriver()
            .flatMapLatest{
                self.validateText($0)
                    .asDriver(onErrorJustReturn: false)
            }

        result
            .map { $0 ? "Ok" : "Error" }
            .drive(lbVisible.rx.text)
            .disposed(by: bag)

        result
            .map{ $0 ? UIColor.blue : UIColor.red }
            .drive(lbVisible.rx.backgroundColor)
            .disposed(by: bag)

        result.drive(btnSend.rx.isEnabled)
            .disposed(by: bag)
    }
    
    
    func validateText(_ value:String?) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            print("== \(value ?? "") Sequence Start ==")
            
            defer {
                print("== \(value ?? "") Sequence Ent ==")
            }
            guard let str = value , let _ = Double(str) else {
                observer.onError(ValidationError.notANumber)
                return Disposables.create()
            }
            
            observer.onNext(true)
            observer.onCompleted()
            
            return Disposables.create()
            
        }
    }
}
