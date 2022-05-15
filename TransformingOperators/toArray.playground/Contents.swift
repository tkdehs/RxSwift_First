import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let subject = PublishSubject<Int>()


// 옵저버블이 끝나는 시점에 모든 이벤트를 배열로 구독자에게 방출한다.
subject.toArray()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.onCompleted()
