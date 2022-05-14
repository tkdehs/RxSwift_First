import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// sike 연잔사가 false가 되는순간부터 모든 연산자를 리턴한다.
// 따라서 아래 홀수인 1일떄는 스킵되고 2가 되는순간부터 구독자에게 전달을 시작한다.
 Observable.from(numbers)
    .skip { i in
        !i.isMultiple(of: 2)
    }.subscribe { i in
        print(i)
    }.disposed(by: disposeBag)

