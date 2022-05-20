import UIKit
import RxSwift

let bag = DisposeBag()

func currentTimeString() -> String{
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}

// 실제로 방출되는 시간은 제시간에 방출하지만 구독자에게 전달되는 시점을 딜레이하여 전달한다.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delay(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe {print(currentTimeString(), $0)}
    .disposed(by: bag)

