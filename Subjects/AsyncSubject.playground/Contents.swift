import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// AsyncSubject는 다른 Subject와는 이벤트를 전달하는 시점의 차이가 있다.
// 다른 Subject는 이벤트가 실행되는 즉시 구독자에게 전달한다.
// AsyncSubject는 completed 이벤트가 실행되기 전까지 구독자에게 전달하지 않는다.

let subject = AsyncSubject<Int>()

subject.subscribe{
    print($0)
}.disposed(by: disposeBag)

// next이벤트가 실행되엇지만 구독자에게 전달되지 않는다.
subject.onNext(1)

subject.onNext(2)
subject.onNext(3)

// completed가 실행되면 가장 최근의 next이벤트가 구독자에게 전달된다.
subject.onCompleted()
// error가 실행되면 아무런 next이벤트도 전달되지 않는다.
subject.onError(MyError.error)
