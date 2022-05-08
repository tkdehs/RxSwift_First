import UIKit
import RxSwift

let bag = DisposeBag()

// 순서가 중요하다
// filter : 필터링, take : 파라미터만큼 방출

Observable.from([1,2,3,4,5,6,7,8,9])
    .filter({ data in
        data.isMultiple(of: 2)
    })
    .take(5)
    .subscribe { print($0) }
    .disposed(by: bag)
