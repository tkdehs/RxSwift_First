import UIKit
import RxSwift

let bag = DisposeBag()

func currentTimeString() -> String{
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}
// 7동안은 아무 이벤트도 출력되지 않는다. 구독시점 자체를 딜레이시켜서 구독자에게 전달된다.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delaySubscription(.seconds(7), scheduler: MainScheduler.instance)
    .subscribe {print(currentTimeString(), $0)}
    .disposed(by: bag)
