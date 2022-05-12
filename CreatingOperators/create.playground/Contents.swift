import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// 옵저버블의 동작을 직적 컨트롤 하고싶다면 create를 사용한다.
let observable = Observable<String>.create { (observer) -> Disposable in
    guard let url = URL(string: "https://www.apple.com") else {
        observer.onError(MyError.error)
        // 리턴형이 disposable이 아닌 dispoeables의 create를 실행해야 한다. 주의
        return Disposables.create()
    }
    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
        // 리턴형이 disposable이 아닌 dispoeables의 create를 실행해야 한다. 주의
        return Disposables.create()
    }
    observer.onNext(html)
    
    observer.onNext("fgefwefwef")
    // onCompleted 또는 onError 를 통해 반드시 옵저버블을 종료 해줘야한다.
    observer.onCompleted()
    
    // completed가 실행 되엇기떄문에 이후는 방출되지 않는다.
    observer.onNext("fgefwefwef")
    
    return Disposables.create()
}

observable.subscribe { html in
    print(html)
}
