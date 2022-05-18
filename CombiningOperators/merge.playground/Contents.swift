import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError : Error {
    case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let nagativeNumbers = BehaviorSubject(value: -1)

let source = Observable.of(oddNumbers, evenNumbers, nagativeNumbers)


// merge 연산자는 여러 옵저버블을 하나로 머지한다.
source
    .merge(maxConcurrent: 2)
    .subscribe{ print($0) }
    .disposed(by: bag)

oddNumbers.onNext(3)
evenNumbers.onNext(4)

evenNumbers.onNext(6)
oddNumbers.onNext(5)

nagativeNumbers.onNext(-2)

// 최대 병합 갯수가 2개이기떄문에 하나가 completed 될되는순간 나머지 하나가 병합되어 2개를 유지한다.
// BehaviorSubject 이기 떄문에 가장 최근의 값인 -2이 방출된다.
oddNumbers.onCompleted()

////oddNumbers.onCompleted()
//// 만약 하나라도 에러이벤트가 전달되면 바로 error를 리턴하고 중단된다.
//oddNumbers.onError(MyError.error)
//evenNumbers.onNext(8)
//// 머지이벤트는 모든 옵저버블이 completed가 되야지만 마지막에 comleted가 전달된다.
//evenNumbers.onCompleted()
