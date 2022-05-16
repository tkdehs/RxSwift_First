import UIKit
import RxSwift

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"


// 옵저버블 안에서 옵저버블을 생성하여 요소들을 변환한뒤 생성된 옵저버블로 방출한다.
// 서브 옵저버블 순서없이 점유하며 방출된다.
Observable.from([redCircle,greenCircle,blueCircle])
    .flatMap { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart).take(5)
        case greenCircle:
            return Observable.repeatElement(greenHeart).take(5)
        case blueCircle:
            return Observable.repeatElement(greenHeart).take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
