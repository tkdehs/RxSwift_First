import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

// withLatestFrom 과 반대이다.
// sample연산자는 동일한 이벤트를 중복해서 전달하지 않는다.

data.sample(trigger)
    .subscribe { print($0) }
    .disposed(by: bag)

trigger.onNext(())
data.onNext("Hellow")
trigger.onNext(())
trigger.onNext(())

// withLatestFrom과는다르게 data에서 completed가 실행된뒤 트리거가 실행되면 completed를 구독자에게 전달한다.
data.onCompleted()
trigger.onNext(())
