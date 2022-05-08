import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError : Error {
    case error
}

let subject = PublishSubject<String>()

subject.onNext("Hello")


let o1 = subject.subscribe{ print(">> 1 ", $0) }
o1.disposed(by: disposeBag)
//publish는 구독되기전에 했던 next이벤트는 새로운 구독자에게 전달되지 않는다.

subject.onNext("RxSwift")

let o2 = subject.subscribe{ print(">> 2 ", $0) }
o2.disposed(by: disposeBag)

subject.onNext("subejct")

//subject.onCompleted()
subject.onError(MyError.error)

let o3 = subject.subscribe{ print(">> 3 ", $0) }
o3.disposed(by: disposeBag)
