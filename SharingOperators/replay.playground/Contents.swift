import UIKit
import RxSwift

let bag = DisposeBag()

// 버퍼크기만큼 저장하고 있다가 다음구독자가 생기면 버퍼에 담겨져 있는것만큼 전달한다.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .replay(5)

source.subscribe{print("🔵", $0)}
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe{ print("🔴", $0)}
    .disposed(by: bag)


source
    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe{ print("💚", $0)}
    .disposed(by: bag)

source.connect().disposed(by: bag)

