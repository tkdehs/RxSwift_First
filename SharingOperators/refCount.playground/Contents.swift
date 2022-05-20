import UIKit
import RxSwift

let bag = DisposeBag()

// refCount는 connet 메소드를 내부에서 자동으로 호출하기떄문에 따로 호출해줄 필요가 없다.
// refCount는 구독이 모두 종료되면 옵저버블도 disposed 된다.
// 새로운구독이 발생되면 다시 생성되며 처음부터 방출하게 된다.
// 리소스관리를 간단하게 구현하여 처리가 가능한 좋은 연산자이다.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug().publish().refCount()

let observer1 = source.subscribe{print("🔵", $0)}

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    observer1.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    // 이미 기존 구독은 끝나서 옵저버블이 종료됬으므로 다시 새롭게 생성되며 0부터 출력된다.
    let observer2 = source.subscribe{ print("🔴", $0)}
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer2.dispose()
    }
}
