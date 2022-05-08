import UIKit
import RxSwift

enum MyError: Error {
    case unKnown
}

let observable = Observable<String>.create { observer in
    observer.onNext("hi")
    observer.onNext("Observable")
    
    
    observer.onCompleted()
    
    return Disposables.create()
}


let infallible = Infallible<String>.create { observer in
    
    observer(.next("Hello"))
    
    
    observer(.completed)
    return Disposables.create()
}
