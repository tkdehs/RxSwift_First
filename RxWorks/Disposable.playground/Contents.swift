import UIKit
import RxSwift


// Dispose : 리소스 관리를 위한 함수.

let subscription1 =  Observable.from([1,2,3])
    .subscribe(onNext: { el in
        print("Next ", el)
    }, onError: { error in
        print("Error ", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: { // 리소스가 해지되는 시점에 실행된다.
        print("Disposed")
    })

subscription1.dispose()

var bag = DisposeBag()


Observable.from([1,2,3])
    .subscribe {
        print($0)
    }
    .disposed(by: bag)

bag = DisposeBag()

// 매초 3씩 증가하는 옵져버블
let subscription2 =  Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { el in
        print("Next ", el)
    }, onError: { error in
        print("Error ", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: { // 리소스가 해지되는 시점에 실행된다.
        print("Disposed")
    })

// 3초뒤에 해당 구독을 dispose 한다.
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose()
}
