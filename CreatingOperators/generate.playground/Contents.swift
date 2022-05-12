import UIKit
import RxSwift

let disposeBag = DisposeBag()
let a = "A"
let b = "B"

// initialState : 초기값
// condition : 끝나는 조건
// iterate : 증가 로직

// 0부터 2씩 증가하는 observable
Observable.generate(initialState: 0) { i in
    i <= 10
} iterate: { i in
    i + 2
}.subscribe { i in
    print(i)
}.disposed(by: disposeBag)


// 10부터 2씩 감소하는 observable
Observable.generate(initialState: 10) { i in
    i >= 0
} iterate: { i in
    i - 2
}.subscribe { i in
    print(i)
}.disposed(by: disposeBag)


// A B 번갈아가면서 출력 observable
Observable.generate(initialState: a) { str in
    str.count <= 15
} iterate: { str in
    // 2의 배수이면 true 리턴. 즉 2의 배수이면 A 추가 아니면 B 추가
    str.count.isMultiple(of: 2) ? str + a : str + b
}.subscribe { i in
    print(i)
}.disposed(by: disposeBag)
