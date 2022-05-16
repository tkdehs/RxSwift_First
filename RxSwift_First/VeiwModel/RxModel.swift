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
    let strSubject = PublishSubject<String>().debounce(.milliseconds(500), scheduler: MainScheduler.instance)
    
}
