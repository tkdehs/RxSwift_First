import UIKit
import RxSwift

let bag = DisposeBag()
enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()


// 에러가 발생시 기본값을 리턴한다. 파라미터의 형식은 옵저버블의 데이터 형식과 같다.
// 그리고 completed를 방출하고 종료된다.
subject
    .catchAndReturn(-1)
    .subscribe{print($0)}
    .disposed(by: bag)

subject.onError(MyError.error)
