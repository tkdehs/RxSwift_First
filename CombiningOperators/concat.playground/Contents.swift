import UIKit
import RxSwift

let bag = DisposeBag()
let fruits = Observable.from(["π", "π", "π", "π", "π", "π"])
let animals = Observable.from(["πΆ", "π±", "π­", "πΉ", "π°", "π»"])

// λ μ°μ°μλ₯Ό ν©μΉλ€.
Observable.concat([fruits,animals])
    .subscribe { print($0) }
    .disposed(by: bag)

print("----------------------------------")

// μΈμ€ν΄μ€λ₯Ό μ΄μ©ν΄μλ ν©μΉλκ² κ°λ₯νλ€.
fruits.concat(animals)
    .subscribe { print($0) }
    .disposed(by: bag)

print("----------------------------------")
animals.concat(fruits)
    .subscribe { print($0) }
    .disposed(by: bag)
