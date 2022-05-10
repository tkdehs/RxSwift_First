import UIKit
import RxSwift

let disposeBag = DisposeBag()
let apple = "🍏"
let orange = "🍊"
let kiwi = "🥝"

Observable.of(apple, orange, kiwi)
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

Observable.of([1,2], [3,4], [5,6])
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

