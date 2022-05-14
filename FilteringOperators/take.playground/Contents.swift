import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


// 특정 갯수만 방출한다
Observable.from(numbers)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
