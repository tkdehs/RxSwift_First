import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// Relay는 Subject와 마찬가지로 다른소스로부터 이벤트를받아서 구독자에게 전달한다.
// 가장큰차이는 next이벤트만 전달한다.
// 그래서 dispose되기 전까지 계속 전달된다
// 주로 UI 이벤트 처리에 사용된다.

let prelay = PublishRelay<Int>()
prelay.subscribe { i in
    print("1: \(i)")
}.disposed(by: disposeBag)

// subject와는 다르게 next가 아닌 accept로 구독자에게 전달한다.
prelay.accept(1)

let brelay = BehaviorRelay(value: 1)
brelay.accept(2)

brelay.subscribe { i in
    print("2: \(i)")
}.disposed(by: disposeBag)

brelay.accept(3)

// behaviorRelay에 저장된 next에 접근해서 값을불러온다. 이값은 읽기전용이다.
print(brelay.value)

let rrelay = ReplayRelay<Int>.create(bufferSize: 3)

(1...10).forEach { i in
    rrelay.accept(i)
}

rrelay.subscribe { i in
    print("3: \(i)")
}.disposed(by: disposeBag)

