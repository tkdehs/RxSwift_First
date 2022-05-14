import UIKit
import RxSwift

let disposeBag = DisposeBag()

let o = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

// 해당 시간이 될때까지 옵저버블이 실행된다.
// 시간상 오차가 존재하기떄문에 3개가 출력되지 않는다.
// skipDuration과는 반대되는 연산자이다
o.take(for: .seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
