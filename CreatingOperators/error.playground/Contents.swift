import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// 옵저버가 에러를 전달 해야 할떄 주로 사용한다.
// 그래서 방출되는 요소의 선언은 중요하지 않다. 보통 Void를 사용한다.
// next 이벤트를 전달하지 않는점이 중요한다.
Observable<Void>.error(MyError.error)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
