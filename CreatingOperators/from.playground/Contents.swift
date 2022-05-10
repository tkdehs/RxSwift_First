import UIKit
import RxSwift

let disposeBag = DisposeBag()
let fruits  = ["🍏","🍎","🍐","🍋","🍌"]

Observable.from(fruits)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
