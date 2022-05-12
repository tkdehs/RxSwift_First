import UIKit
import RxSwift

let disposeBag = DisposeBag()

// empty 연산자는 요소를 방출하지않는다.
// 그래서 방출되는 요소의 선언은 중요하지 않다. 보통 Void를 사용한다.
// 옵저버가 아무런 동작없이 종료해야할 때 사용된다.
// next 이벤트를 전달하지 않는점이 중요한다.
Observable<Void>.empty()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
