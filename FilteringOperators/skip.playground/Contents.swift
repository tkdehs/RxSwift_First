import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 스킵숫자만큼 방출되는걸 무시하고 이후의 요소를 구독자에게 전달한다.
// 인덱스가 아닌 count를 사용하여 갯수만큼 무시한다.
Observable.from(numbers)
    .skip(3)
    .subscribe{ print($0) }
    .disposed(by: disposeBag)
