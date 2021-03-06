import UIKit
import RxSwift

let disposeBag = DisposeBag()

let redCircle = "๐ด"
let greenCircle = "๐ข"
let blueCircle = "๐ต"

let redHeart = "โค๏ธ"
let greenHeart = "๐"
let blueHeart = "๐"


// ๊ธฐ๋ณธ์ ์ธ ํ๋ผ๋ฏธํฐ๋ flatMap๊ณผ ๋์ผํ๋ค.
// ํ์ง๋ง ์ฒ์ ์คํ๋ ์ต์ ๋ฒ๋ธ๋ง ์คํํ์ฌ ๋ฐฉ์ถํ๋ค.
// ์๋์ฒ๋ผ ๊ฑฐ์ ๋์์ ๋ฐฉ์ถ๋๋ ์ต์ ๋ฒ๋ธ์ ์์ฑํ ๊ฒฝ์ฐ ์ฒ์ ์์ฑ๋ ์ต์ ๋ฒ๋ธ ์ธ์๋ ๊ธฐํ๋ฅผ ์ป์ง ๋ชปํ๋ค.

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
// 0.2 ์ด๋ง๋ค ํ๊ฐ์ฉ 10๋ฒ ๋ฐฉ์ถํ๋ ์๋ธ์ ํธ ์์ฑ
// ์คํ๋๋์ฃผ๊ธฐ๊ฐ ๋ง๋ฌผ๋ฆฌ์ง๊ฐ ์๋๋ค๋ฉด ๋ค๋ฅธ ์ต์ ๋ฒ๋ธ์ด ์คํ๋  ์ ์๋ค.
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

// ๋ค๋ฅธ ์ฃผ๊ธฐ๋ก ์คํ๋๊ธฐ ๋๋ฌธ์ ์ด๋ก์์ด ์คํ๋๊ฒ ๋๋ค.
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    sourceObservable.onNext(greenCircle)
}

// ๋ค๋ฅธ ์ฃผ๊ธฐ๋ก ์คํ๋๊ธฐ ๋๋ฌธ์ ํ๋์์ด ์คํ๋๊ฒ ๋๋ค.
DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
    sourceObservable.onNext(blueCircle)
}
