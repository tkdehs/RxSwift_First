import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

trigger.withLatestFrom(data)
    .subscribe { print($0) }
    .disposed(by: bag)

// 아직 트리거 이벤트가 실행되지 않았기 떄문에 구독자에게 전달되지 않는다.
data.onNext("Hellow")

//트리거 이벤트가 실행되고나서야 구독자에게 전달된다.
trigger.onNext(())
//트리거가 한번더 실행되면 최신 데이터 옵저버블의 이벤트가 구독자에게 전달된다.
trigger.onNext(())

//데이터 서브젝트가 completed가 전달되도 구독자에게는 마지막 next가 전달된다.
//danjata.onCompleted()
//error의 경우는 바로 error를 방출하고 종료된다.
data.onError(MyError.error)
trigger.onNext(())

// trigger가 completed가 된경우 바로 구독자에게 completed를 전달한다.
trigger.onCompleted()

