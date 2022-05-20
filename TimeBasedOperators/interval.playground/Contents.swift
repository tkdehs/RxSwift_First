import UIKit
import RxSwift

let i = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

let subscription1 = i.subscribe { print("1 >> \($0)") }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscription1.dispose()
}


// 2초뒤에 새로운 구독자가 추가되도 다시 0부터 방출한다.
var subscription2: Disposable?

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    subscription2 = i.subscribe { print("2 >> \($0)") }
}
DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    subscription2?.dispose()
}
