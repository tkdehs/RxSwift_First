import UIKit
import RxSwift

let disposeBag = DisposeBag()

let redCircle = "π΄"
let greenCircle = "π’"
let blueCircle = "π΅"

let redHeart = "β€οΈ"
let greenHeart = "π"
let blueHeart = "π"


// μ΅μ λ²λΈ μμμ μ΅μ λ²λΈμ μμ±νμ¬ μμλ€μ λ³ννλ€ μμ±λ μ΅μ λ²λΈλ‘ λ°©μΆνλ€.
// μλΈ μ΅μ λ²λΈ μμμμ΄ μ μ νλ©° λ°©μΆλλ€.
// map: μμλ€λ§ λ°κΎΌλ€. flatmap: μ΅μ λ²λΈμ μλ‘μ΄ μ΅μ λ²λΈλ‘ λ³ννλ€.
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
