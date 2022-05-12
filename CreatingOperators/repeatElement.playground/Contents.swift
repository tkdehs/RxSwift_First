import UIKit
import RxSwift

let disposeBag = DisposeBag()
let element = "H"

// take를 설정해주지 않으면 무한정 반복하기 때문에 설정해줘야한다.
Observable.repeatElement(element)
    .take(7)
    .subscribe { str in
        print(str)
    }
