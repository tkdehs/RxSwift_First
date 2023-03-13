import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

// zip은 인덱스기준으로 서로 결합한다. 중복으로 결합하지 않는다.
// 첫번째요소는 첫번째요소끼리 두번째요소는두번쩨요소끼리 결합한다.

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

Observable.zip(numbers, strings) { "\($0) - \($1)" }
    .subscribe{ print($0) }
    .disposed(by: bag)


numbers.onNext(1)
strings.onNext("one")

numbers.onNext(2)
numbers.onNext(3)
numbers.onNext(4)
numbers.onNext(5)
// 항상 짝을 맞추어 방출되기때문에 2만 numbers에서 방출될경우 방출되지않는다.
strings.onNext("two")
strings.onNext("tree")
strings.onNext("for")

// 한쪽에서만 completed가 전달된경우 다른쪽에서 completed가 전달될떄까지 전달되지 않는다.
//numbers.onCompleted()
// error가 발생한경우는 즉기 error를 방출한뒤 종료된다.
numbers.onError(MyError.error)
strings.onNext("three")



