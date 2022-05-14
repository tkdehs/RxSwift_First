import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

// 필터연산자의 결과가 true 인경우만 구독자에게 전달된다.
// 짝수데이터만 방출하는 filter이다.
Observable.from(numbers)
    .filter({ i in
        i.isMultiple(of: 2)
    })
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)
