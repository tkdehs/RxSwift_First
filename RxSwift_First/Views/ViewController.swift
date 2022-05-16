//
//  ViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/07.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {

    var textfield = UITextField()
    var viewModel: RxModel = RxModel.shard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(textfield)
        
        textfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        textfield.addTarget(controlEvents: .editingChanged) {
            
        }
    }
    
    func set
}


extension UIControl {
    
    /// 타겟 추가
    ///
    /// - Parameters:
    ///   - controlEvents: 컨트롤 이벤트
    ///   - action: 액션
    func addTarget (controlEvents: UIControl.Event = .touchUpInside, action: @escaping ()->()) {
        let sleeve = ClosureSleeve(action)
         addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    class ClosureSleeve {
        let closure: ()->()
        
        init (_ closure: @escaping ()->()) {
            self.closure = closure
        }
        
        @objc func invoke () {
            closure()
        }
    }
}
