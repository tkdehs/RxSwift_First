[
    import UIKit
    import RxSwift

    let bag = DisposeBag()

    enum MyError: Error {
        case error
    }

    let o = Observable.range(start: 1, count: 5)

    print("== scan")

    // scan 연산자는 누적시켜가며 연산을하고 결과를 구독자에게 방출한다.
    // 중간과정이필요할경우 주로 사용한다.
    o.scan(0, accumulator: +)
        .subscribe {print($0)}
        .disposed(by: bag)

    print("== scan")

    print("== reduce")
    // scan 연산자와는 달리 중간과정은 방출하지않고 마지막 결과만 구독자에게 방출한다.
    o.reduce(0, accumulator: +)
        .subscribe {print($0)}
        .disposed(by: bag)
    print("== reduce")

]
