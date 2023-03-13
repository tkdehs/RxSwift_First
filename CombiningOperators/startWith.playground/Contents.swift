import UIKit
import RxSwift

let bag = DisposeBag()
let numbers = [1, 2, 3, 4, 5]


// 앞부분에 값이 추가된다.
// 만약 연달아추가한다면 순서대로 추가가 된다.
Observable.from(numbers)
    .startWith(0)
    .startWith(-1, -2)
    .startWith(-3)
    .subscribe { print($0)}
    .disposed(by: bag)

