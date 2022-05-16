import UIKit
import RxSwift

let bag = DisposeBag()


// observable안에서 observable을 방출하는 buffer 라 할수 있다.
// inner observable은 count 갯수반큼 방출한뒤 completed가 실행되며 종료된다.
// buffer와 마찬기지로 timeSpan에 걸릴경우 갯수를 다 채우지 않아도 completed가 실행되고 종료된다.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe{
        print($0)
        if let observable = $0.element {
            observable.subscribe{ print("inner : \($0)") }
        }
    }
    .disposed(by: bag)
