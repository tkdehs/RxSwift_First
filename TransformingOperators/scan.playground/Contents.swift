import UIKit
import RxSwift

let bag = DisposeBag()

// 시작 요소를 정하고 accumulator에서 연산한뒤 결과값을 옵저버블로 리턴한다.
// 시작값은 계속 누적된다.
Observable.range(start: 1, count: 10)
    .scan(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag)
