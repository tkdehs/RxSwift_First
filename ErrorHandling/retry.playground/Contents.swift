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

// 실제 재시도 횟수는 6. 정확하게 재시도 하려면 원하는 횟수 + 1을 하여 전달하면된다.
source
    .retry(7)
    .subscribe{print($0)}
    .disposed(by: bag)
