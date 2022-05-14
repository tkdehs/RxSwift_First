import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


// single 연산자는 단 하나의 요소만 방출되는것을 보장한다.
// 2개이상의 요소가 방출될경우 error를 방출한다.
Observable.just(1)
    .single()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

Observable.from(numbers)
    .single()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

// predicate 를 작성할경우 해당 조건에 맞는경우만방출 할 수도 있다.
Observable.from(numbers)
    .single { $0 == 3 }
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

let subject = PublishSubject<Int>()

subject.single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// next 이벤트가 방출도됫다고 해서 바로 onCompleted를 방출하지 않는다.
// 만약 여기서 onNext가 한번더 실행된다면 error를 방출되지않으며
// completed가 방출하기전까지는 대기한다.
subject.onNext(100)
