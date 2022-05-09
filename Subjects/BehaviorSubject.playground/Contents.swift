import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let p = PublishSubject<Int>()

p.subscribe { print("publishSubejct >>" , $0) }
    .disposed(by: disposeBag)

let b = BehaviorSubject<Int>(value: 0)

b.subscribe { print("BehaviorSubject >>", $0) }
    .disposed(by: disposeBag)
// 새로운 이벤트 추가
b.onNext(1)

// 새로운 옵져버 추가
b.subscribe { print("BehaviorSubject2 >>", $0) }
    .disposed(by: disposeBag)
// 가장 최신 next 이벤트를 옵저버로 전달함.

b.onCompleted()
//b.onError(MyError.error)

// completed 이벤트가 전달되었기 떄문에 새로운 옵져버도 completed가 전달됨 error 이벤트도 마찬가지임.
b.subscribe { print("BehaviorSubject3 >>", $0) }
    .disposed(by: disposeBag)

