import UIKit
import RxSwift

let bag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

// groupBy 에서 키값으로 요소들을 묶는다
// 묶은 요소들은 groupedObservable로 리턴된다.
// 보통 faltMap을통해 리스트형태로 변환한뒤 사용한다.
Observable.from(words)
    .groupBy{ $0.first ?? Character(" ") }
    .flatMap{ $0.toArray()}
    .subscribe{ print($0) }
    .disposed(by: bag)

// 1~10까지의 숫자를 홀짝으로 나누는 옵저버블
Observable.range(start: 1, count: 10)
    .groupBy { $0.isMultiple(of: 2) }
    .flatMap{ $0.toArray()}
    .subscribe{ print($0) }
    .disposed(by: bag)
