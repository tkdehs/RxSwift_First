import UIKit
import RxSwift

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()


// takeUntil은 트리거 역할을 하는 옵저버블이 next이벤트가 실행될때까지 구독자에게 전달한다.
// trigger옵저버블이 실행되면 대상 옵저버블은 completed가 실행된다.
// skip과는 반대의 연산을 한다.
subject.take(until: trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)

trigger.onNext(1)
subject.onNext(3)


// util로 조건을 지정하고 해당 조건이 false가 되는순간 completed 이벤트가 실행된다.
subject.take(until: { $0 > 5 }, behavior: .exclusive)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)

subject.onNext(5)
subject.onNext(7)
