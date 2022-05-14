import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// takeWhile은 false가 리턴되면 이후에는 completed 또는 error만 구독자에게 전달한다.
// skip과는 반대의 연산을 한다.
// exclusive : 마지막 연산이 true 일때만 방출한다.
// inclusive : 마지막에 조건이 false여도 방출한다. 조건에 맞지 않아도 방출하기 떄문에 도건을 잘못이해 할 수 있기에 특별한 경우가 아니면 사용하지 않는편이다.
Observable.from(numbers)
    .take(while: { i in
        // 홀수일때 true 리턴
        !i.isMultiple(of: 2)
    }, behavior: .inclusive)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
