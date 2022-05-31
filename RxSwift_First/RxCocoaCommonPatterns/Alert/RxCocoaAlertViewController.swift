//
//  RxCocoaAlertViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/31.
//

import UIKit
import RxSwift
import RxCocoa

class RxCocoaAlertViewController: UIViewController {

    @IBOutlet weak var vColor: UIView!
    
    @IBOutlet weak var btnOneAction: UIButton!
    
    @IBOutlet weak var btnTwoAction: UIButton!
    
    @IBOutlet weak var btnActionSheet: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnOneAction.rx.tap
            .flatMap { [unowned self] in
                self.info(title: "Current Color", message: self.vColor.backgroundColor?.rgbHexString)
            }
            .subscribe(onNext: { [unowned self] actionType in
                switch actionType {
                case .ok:
                    print(self.vColor.backgroundColor?.rgbHexString ?? "")
                default:
                    break
                }
            })
            .disposed(by: bag)
        
        btnTwoAction.rx.tap
            .flatMap { [unowned self] in
                self.alert(title: "Reset Color", message: "Reset to black color?")
            }.subscribe(onNext: {
                [unowned self] actionType in
                switch actionType {
                case .ok:
                    self.vColor.backgroundColor = UIColor.black
                default:
                    break
                }
            })
            .disposed(by: bag)
        
        btnActionSheet.rx.tap
            .flatMap{
                [unowned self] in
                self.colorActionSheet(colors: MaterialBlue.allColors, title: "Change Color",message: "Choose One")
            }.subscribe(onNext: {
                [unowned self] color in
                self.vColor.backgroundColor = color
            })
            .disposed(by: bag)
    }
}

enum ActionType {
    case ok
    case cancel
}

extension UIViewController {
    func info(title: String, message: String? = nil) -> Observable<ActionType> {
        return Observable.create { [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) {
                _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alert.addAction(okAction)
            
            self?.present(alert, animated: true, completion: nil)
            
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func alert(title: String, message:String? = nil) -> Observable<ActionType> {
        return Observable.create { [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) {
                _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alert.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                _ in
                observer.onNext(.cancel)
                observer.onCompleted()
            }
            alert.addAction(cancelAction)
            
            self?.present(alert, animated: true, completion: nil)
            
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func colorActionSheet(colors: [UIColor], title:String, message: String? = nil) -> Observable<UIColor> {
        return Observable.create {
            [weak self] observer in
            let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            for color in colors {
                let colorAction = UIAlertAction(title: color.rgbHexString, style: .default) {
                    _ in
                    observer.onNext(color)
                    observer.onCompleted()
                }
                actionSheet.addAction(colorAction)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                _ in
                observer.onCompleted()
            }
            actionSheet.addAction(cancelAction)
            
            self?.present(actionSheet, animated: true, completion: nil)
            
            return Disposables.create {
                actionSheet.dismiss(animated: true,completion: nil)
            }
            
        }
    }
    
}
