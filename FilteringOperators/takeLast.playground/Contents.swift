import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let subject = PublishSubject<Int>()


// 버퍼가 2개인 takeLast 생성
subject.takeLast(2)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

numbers.forEach{
    subject.onNext($0)
}
subject.onNext(11)

// takeLast 연산자는 completed가 실행되기 전까지는 구독자에게 전달하지않고 버퍼만큼의 next이벤트를 담고있다.
// completed가 실행되면 구독자에게 마지막 버퍼에담긴 이벤트를 방출한다.
subject.onCompleted()

enum MyError : Error {
    case error
}

// error가 실행되면 방출되지않고 error이벤트만 구독자에게 전달한다.
subject.onError(MyError.error)
