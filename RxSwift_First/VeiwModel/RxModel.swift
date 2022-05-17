//
//  RxModel.swift
//  RxSwift_First
//
//  Created by sangdon kim on 2022/05/16.
//

import Foundation
import RxSwift

class RxModel {
    static let shard = RxModel()
    let bag = DisposeBag()
    let strSubject = PublishSubject<String>()
    
}
