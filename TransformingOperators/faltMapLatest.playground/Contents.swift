import UIKit
import RxSwift

let disposeBag = DisposeBag()

let redCircle = "π΄"
let greenCircle = "π’"
let blueCircle = "π΅"

let redHeart = "β€οΈ"
let greenHeart = "π"
let blueHeart = "π"

let sourceObservable = PublishSubject<String>()
let trigger = PublishSubject<Void>()


// κΈ°λ³Έμ μΈ νλΌλ―Έν°λ flatMapκ³Όλ λμΌνλ€
// μλΈμ΅μ λ²λΈμ΄ μ΄λ―Έ μ€νμ€μ΄λΌλ©΄ μ κ±°νκ³  λμ€μ μ€νλ μ΅μ λ²λΈμ΄ μ€νλλ€.
// λ§μ½ λ€μ κ°μ μμκ° λ€μ΄μ€λλΌλ κΈ°μ‘΄μ μ°λ μ΅μ λ²λΈμ μ¬μ¬μ©νλκ²μ΄ μλ μ¬μμ±νμ¬ μ¬μ©λλ€.
sourceObservable
    .flatMapLatest { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in redHeart }
                .take(until: trigger)
        case greenCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in greenHeart }
                .take(until: trigger)
        case blueCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in blueHeart }
                .take(until: trigger)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

sourceObservable.onNext(redCircle)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    sourceObservable.onNext(greenCircle)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    sourceObservable.onNext(blueCircle)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    sourceObservable.onNext(redCircle)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    trigger.onNext(())
}

