import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

// 두개의 옵저버블의 요소들을 합쳐 하나의 옵저버블로 리턴한다.
Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
    .subscribe {print($0)}
    .disposed(by: bag)

greetings.onNext("Hi")
languages.onNext("World!")

greetings.onNext("Hello")

languages.onNext("RxSwift!")

// 만약 하나라도 에러가 전달되면 즉시 구독자에게 전달하고 중단된다.
greetings.onError(MyError.error)
greetings.onCompleted()
// 하나가 중단되더라도 마지막 값을 가지고 전달된다.
languages.onNext("gogo")

// 두개다 종료됬을경우 completed 가 전달된다.
languages.onCompleted()
