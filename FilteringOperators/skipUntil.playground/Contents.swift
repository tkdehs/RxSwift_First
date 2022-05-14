import UIKit
import RxSwift

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

// 첫번째 서브젝트를 구독하고 두번째 서브젝트를 트리거로 사용한다.
subject.skip(until: trigger)
    .subscribe {print($0)}
    .disposed(by: disposeBag)

// 트리거가 방출되지 않았으므로 아무일도 일어나지 않는다.
subject.onNext(1)

// 트리거가 방출되고 나서야 원본 옵저버가 방출을 시작한다.
// 따라서 이전에 방출됬던 1은 방출하지 않는다.
trigger.onNext(0)

//트거가 방출되었으므로 방출된다.
subject.onNext(2)

