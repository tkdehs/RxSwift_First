import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()


// catch 연산자는 error가 발생했을때 새로운 옵저버블로 교체하는 방식으로 에러를 처리한다.
subject
    .catch({ _ in
        recovery
    })
    .subscribe{print($0)}
    .disposed(by: bag)


subject.onError(MyError.error)
subject.onNext(123)
subject.onNext(123)

recovery.onNext(22)
recovery.onCompleted()
