import UIKit
import RxSwift

var bag = DisposeBag()

// amb는 제일 처음 실행된 이벤트의 옵저버블을 제외한 다른 옵저버블의 이벤트는 무시한다.
// 다른 옵저버블이 completed, error가 실행되어도 무시된다.

let a = PublishSubject<String>()
let b = PublishSubject<String>()
let c = PublishSubject<String>()
//
//a.amb(b)
//    .subscribe { print($0)}
//    .disposed(by: bag)
//
//a.onNext("A")
//b.onNext("B")
//
//b.onCompleted()
//a.onCompleted()

Observable.amb([a,b,c])
    .subscribe { print($0)}
    .disposed(by: bag)

a.onNext("A")
b.onNext("B")
c.onNext("C")
