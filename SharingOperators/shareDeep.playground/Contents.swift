import UIKit
import RxSwift

let bag = DisposeBag()

// share연산자가 리턴하는 옵저버블은 refCount 연산자로 리턴된 옵저버블이다.
// replay : 설정해줄경우 replay가 실행되며 버퍼사이즈를 정하는 정수다
// scope : .forever를 설정할경우 하나의 옵저버블을 공유한다.
// 하지만 시퀀스는 새로 생기므로 이전에 설정됬던 이벤트는 버퍼의 갯수만큼 실행되지만 다시 처음부터 시작되는 시퀀스가 실행된다.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .share(replay: 5,scope: .forever)


let observer1 = source.subscribe{print("🔵", $0)}

let observer2 = source.delaySubscription(.seconds(3), scheduler: MainScheduler.instance).subscribe{print("🔴", $0)}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    observer1.dispose()
    observer2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer3 = source.subscribe{print("⚫️", $0)}
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer3.dispose()
    }
}
