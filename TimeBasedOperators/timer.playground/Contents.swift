import UIKit
import RxSwift

let bag = DisposeBag()

// timer 에서는 첫번째 파라미터는 구독자에게 전달된 시기이다.
// 따라서 아래코드는 1초뒤에 0이방출되고 옵저버블이 종료된다.
//Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: bag)


// 1초뒤부터 0.5 초 간격으로 숫자가 방출된다.
Observable<Int>.timer(.seconds(1),period: .milliseconds(500) , scheduler: MainScheduler.instance)
    .take(10)
    .subscribe { print($0) }
    .disposed(by: bag)




