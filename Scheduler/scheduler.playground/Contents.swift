import UIKit
import RxSwift

let bag = DisposeBag()

let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

// 스케줄러는 따로 작성된게 없으니 기본스케줄러인 currentScheduler에서 실행된다.
// observe(on:) 을통해 스케줄러를 변경할 수 있다.
// subscribe(on:) 은 옵저버블이 어느 스케줄러에서 실행될지를 결정하는 메소드이다. 어디에서 실행시키든 같은 동작을보이기 떄문에
// 어디에서 실행하든 상관없다. subscribe의 스케줄을 결장하는것이 아니니 주의
Observable.of(1,2,3,4,5,6,7,8,9)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observe(on: backgroundScheduler)
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    // 옵저버블의 실행 스케쥴을 설정( 어디에서 선언해주던 같다. )
    .subscribe(on: MainScheduler.instance)
    // subscribe의 스케줄을 메인으로 변경
    .observe(on: MainScheduler.instance)
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
        print($0)
    }
    .disposed(by: bag)

