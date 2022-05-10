import UIKit
import RxSwift

let disposeBag = DisposeBag()
let element = "😀"

Observable.just(element)
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

Observable.just([1,2,3])
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

