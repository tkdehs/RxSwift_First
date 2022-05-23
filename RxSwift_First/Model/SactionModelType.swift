//
//  SactionModelType.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/23.
//

import RxDataSources

public protocol SactionModelType {
    associatedtype Item
    var items:[Item] {get}
    init(original: Self, items:[Item])
}
