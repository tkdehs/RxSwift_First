import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) START")
    
    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }
    
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create {
        print("#\(currentAttempts) END")
    }
}

let trigger = PublishSubject<Void>()

// 트리거 서브젝트가 next 이벤트를 방출하면 다시시도한다.
source
    .retry(when: { _ in
        trigger
    })
    .subscribe{print($0)}
    .disposed(by: bag)

trigger.onNext(())

trigger.onNext(())
