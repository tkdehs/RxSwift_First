import UIKit
import RxSwift

let disposeBag = DisposeBag()

// 1부터 1씩 10번 방출하는 옵저버블
Observable.range(start: 1, count: 10)
    .subscribe { i in
        print(i)
    }.disposed(by: disposeBag)
