import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()


let source = PublishSubject<Observable<String>>()

// switchLatest는 옵저버블을 구독하는 옵저버블을 사용할때 주로 사용한다.
// 문자그대로 구독중인 옵저버블을 스위칭 해주는 연산자 이다.
source
    .switchLatest()
    .subscribe {print($0)}
    .disposed(by: bag)

// source가 아직발생한 이벤트가 없기떄문에 구독자에게 방출되지않는다.
a.onNext("1")
b.onNext("b")

// source가 a를 구독했으므로 a로 이벤트가 전달되면 구독자에게 전달되고 b로는 이벤트가 전달되도 구독자에게 전달되지 않는다.
source.onNext(a)

a.onNext("2")
b.onNext("b")

// b가 구독됬으므로 b의 이벤트가 구독자에게 전달된다.
source.onNext(b)

a.onNext("3")
b.onNext("c")

// a는 현재 source가 구독중이지 않으므로 전달되지 않는다.
// b의경우는 b만 completed가 된다고 전달되지않는다. source도 같이 completed가 되는순간 전달된다.
//a.onCompleted()
//b.onCompleted()
//
//source.onCompleted()

// a가 error가 발행되어도 source가 구독중이지 않으므로 전달되지않는다.
// b의경우는 error가 발행된순간 구독자에게 전달하고 종료된다.
a.onError(MyError.error)
b.onError(MyError.error)
