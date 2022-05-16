import UIKit
import RxSwift

let bag = DisposeBag()

// 수집할 시간을 지정하고 수집할 최대 갯수를 지정하여 시간이 경과하거나 최대 수집을 달성하였을경우 방출한다.
Observable<Int>.interval(.milliseconds(1000), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe{ print($0) }
    .disposed(by: bag)
