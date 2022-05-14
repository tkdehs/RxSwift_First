import UIKit
import RxSwift

let disposeBag = DisposeBag()
let fruits = ["🍏","🍎","🍋","🍓","🍇"]


// ignoreElements 는 error와 completed만 방출한다.
// 옵저버블이 성공이냐 실패냐만 판단해서 필터링하는 연산자이다.
// RxSwift5 에서는 ignoreElements 가 Completable을 리턴한다.
// RxSwift6 부턴 ignoreElements 가 Observable<Never>을 리턴한다.
Observable.from(fruits)
    .ignoreElements()
    .subscribe { str in
        print(str)
    }
    .disposed(by: disposeBag)

