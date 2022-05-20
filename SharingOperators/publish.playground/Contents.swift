import UIKit
import RxSwift

let bag = DisposeBag()

//전체적인 로직은 multicast 와 동일하다. 대신 따로 서브젝트를 생성하지않아도 내부적으로 publishSubject를 생성하여 관리하기떄문에 따로 생성해줄필요가 없다.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .publish()

source.subscribe{print("🔵", $0)}
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe{ print("🔴", $0)}
    .disposed(by: bag)

source.connect().disposed(by: bag)
