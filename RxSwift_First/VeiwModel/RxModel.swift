//
//  RxModel.swift
//  RxSwift_First
//
//  Created by sangdon kim on 2022/05/16.
//

import Foundation
import RxSwift
import RxCocoa

class RxModel {
    static let shard = RxModel()
    let bag = DisposeBag()
    let tableSubject = BehaviorRelay(value: [MySection]())
    
}
