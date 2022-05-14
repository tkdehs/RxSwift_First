import UIKit
import RxSwift

let disposeBag = DisposeBag()
let fruits = ["🍏","🍎","🍋","🍓","🍇"]

// 특정 인덱스에 있는 것만 제한적으로 방출하는 연선자이다.
// 1번 인덱스에 있는것만 방출하는 예제
Observable.from(fruits)
    .element(at: 1)
    .subscribe {print($0)}
    .disposed(by: disposeBag)
