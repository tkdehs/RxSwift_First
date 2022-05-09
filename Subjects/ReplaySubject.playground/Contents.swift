import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let rs = ReplaySubject<Int>.create(bufferSize:  3)

(1...10).forEach {
    rs.onNext($0)
}

// 3개가 나온이유는 버퍼가 3이기 떄문에 . 버퍼가 3이면 마지막 next 이벤트 3개가 저장된다.
rs.subscribe {
    print("Observer 1 >>", $0)
}.disposed(by: disposeBag)

// 새로운 구독자가 추가되면 BehaviorSubject와 비슷하게 마지막에 저장된 next 이벤트가 버퍼의 갯수만큼 실행된다.
rs.subscribe {
    print("Observer 2 >>", $0)
}.disposed(by: disposeBag)

// 새로운 next 이벤트가 발생되면 가장 처음 버퍼에 담겨진 이벤트 (8)이 삭제된다.
rs.onNext(11)

// 새로운 구독자가 발생하면 가장 최근 숫자인 9 10 11이 출력된다.
// 버퍼가 크면 클수록 메모리를 많이 잡아먹기떄문에 유의하여 사용하여야 한다.
rs.subscribe {
    print("Observer 3 >>", $0)
}.disposed(by: disposeBag)

rs.onCompleted()
rs.onError(MyError.error)

// 다른 Subject와는 다르게 completed와 error가 발생한뒤 새로운 구독자가 추가되면 버퍼의 next 이벤트를 다 실행한뒤 completed와 error가 실행된다.
rs.subscribe {
    print("Observer 4 >>", $0)
}.disposed(by: disposeBag)
