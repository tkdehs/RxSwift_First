import UIKit
import RxSwift

struct Person {
    let name : String
    let age : Int
}

let disposeBag = DisposeBag()
let numbers = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,1]
let tuples = [(1,"하나"),(1,"일"),(1,"one")]
let persons = [
    Person(name: "Sam", age: 12),
    Person(name: "ShaSha", age: 12),
    Person(name: "Kate", age: 56)
]

// 바로 이전요소와 비교하여 동일한 요소일경우 방출하지 않는다.
// 이후 동일한요소가 나와도 방출한다.
Observable.from(numbers)
    .distinctUntilChanged()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)
print("--------------------")

// 클로저를 통하여 조건을 설정 가능하다. 조건이 true일경우 방출하지 않는다.
Observable.from(numbers)
    .distinctUntilChanged({ num1, num2 in
        !num1.isMultiple(of: 2) && !num2.isMultiple(of: 2)
    })
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

print("--------------------")

// 튜플의 어떤 값을 비교할지 지정할 수 있다.
// 0번일경우 1이므로 1개만 방출되고 1번일경우 전부 방출되는걸 볼 수 있다.
Observable.from(tuples)
    .distinctUntilChanged {
        $0.1
    }
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

print("--------------------")

// 키패스로 전달하요 비교할 인자를 선택할 수 있다.
Observable.from(persons)
    .distinctUntilChanged(at: \.age)
    .subscribe{ print($0) }
    .disposed(by: disposeBag)
