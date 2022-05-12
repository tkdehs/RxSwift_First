import UIKit
import RxSwift

let disposeBag = DisposeBag()
let animals = ["개","쥐","소","말","여우","호랑이"]
let fruits = ["사과","귤","배","포도","멜론","딸기","복숭아"]
var flag = true

// flag를 토글하며 flag 조건에 따라 obserable를 바꾼다.
let factory:Observable<String> = Observable.deferred {
    flag.toggle()
    
    if flag {
        return Observable.from(animals)
    } else {
        return Observable.from(fruits)
    }
}

factory.subscribe {
    print($0)
}.disposed(by: disposeBag)


factory.subscribe {
    print($0)
}.disposed(by: disposeBag)
