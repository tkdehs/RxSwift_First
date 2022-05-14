import UIKit
import RxSwift

let disposeBag = DisposeBag()

let o = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

// 3초 이후부터 방출을 시작한다.
// 2가 찍히는 이유는 약간의 오차가 있기 떄문이다.
o.take(10)
    .skip(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0)}
    .disposed(by: disposeBag)

