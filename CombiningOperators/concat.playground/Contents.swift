import UIKit
import RxSwift

let bag = DisposeBag()
let fruits = Observable.from(["🍏", "🍎", "🍐", "🍊", "🍋", "🍌"])
let animals = Observable.from(["🐶", "🐱", "🐭", "🐹", "🐰", "🐻"])

// 두 연산자를 합친다.
Observable.concat([fruits,animals])
    .subscribe { print($0) }
    .disposed(by: bag)

print("----------------------------------")

// 인스턴스를 이용해서도 합치는게 가능하다.
fruits.concat(animals)
    .subscribe { print($0) }
    .disposed(by: bag)

print("----------------------------------")
animals.concat(fruits)
    .subscribe { print($0) }
    .disposed(by: bag)
