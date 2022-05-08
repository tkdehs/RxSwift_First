import UIKit
import RxSwift

// #1
let o1 = Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(0))
    observer.onNext(1)
    
    observer.onCompleted()
    
    return Disposables.create()
}

o1.subscribe { event in
    print("== start ==")
    print(event)
    
    if let elem = event.element {
        print(elem)
    }
    print("== End ==")
}

print("--------------------")

o1.subscribe(onNext: { elem in
    print(elem)
    
})



// #2
Observable.from([0, 1])


