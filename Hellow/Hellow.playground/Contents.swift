import UIKit
import RxSwift

let disposeBag = DisposeBag()

Observable.just("Hello, RxSiwft")
    .subscribe { print($0) }
    .disposed(by: disposeBag)
