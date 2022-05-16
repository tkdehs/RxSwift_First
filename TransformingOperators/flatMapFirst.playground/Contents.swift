import UIKit
import RxSwift

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"


// 기본적인 파라미터는 flatMap과 동일하다.
// 하지만 처음 실행된 옵저버블만 실행하여 방출한다.
// 아래처럼 거의 동시에 방출되는 옵저버블을 생성할경우 처음 생성된 옵저버블 외에는 기회를 얻지 못한다.

Observable.from([redCircle, greenCircle, blueCircle])
    .flatMapFirst { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart).take(5)
        case greenCircle:
            return Observable.repeatElement(greenHeart).take(5)
        case blueCircle:
            return Observable.repeatElement(blueHeart).take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

print("------------------------------------")
// 0.2 초마다 한개씩 10번 방출하는 서브젝트 생성
// 실행되는주기가 맞물리지가 않는다면 다른 옵저버블이 실행될 수 있다.
let sourceObservable = PublishSubject<String>()
sourceObservable
    .flatMapFirst { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in redHeart }
                .take(10)
        case greenCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in greenHeart }
                .take(10)
        case blueCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in blueHeart }
                .take(10)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

sourceObservable.onNext(redCircle)

// 다른 주기로 실행되기 떄문에 초록색이 실행되게 된다.
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    sourceObservable.onNext(greenCircle)
}

// 다른 주기로 실행되기 떄문에 파랑색이 실행되게 된다.
DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
    sourceObservable.onNext(blueCircle)
}
