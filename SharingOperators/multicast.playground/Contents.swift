import UIKit
import RxSwift

let bag = DisposeBag()
let subject = PublishSubject<Int>()


// multicast 연산자는 하나의 옵저버블을 공유하는 가장 기본적인 공유 연산자이다.
// multicast 없이 실행할 경우 처음부터 구독하는 구독자가 2개가 생기지만
// 설정해줄경우 하나의 옵저버블을 공유하여 3초뒤 요소부터 구독하는 구독자가 생성된다.
// multicast를 설정해주면 리턴형태가 ConnectableObservable로 바뀌게 된다.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .multicast(subject)


source.subscribe{print("🔵", $0)}
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe{ print("🔴", $0)}
    .disposed(by: bag)

// connect 메소드를 실행해주어야 옵저버블이 실행된다. 리턴형태는 Disposable 이므로 disposedbag에 담아 한꺼번에 처리가 가능하다.
source.connect().disposed(by: bag)
