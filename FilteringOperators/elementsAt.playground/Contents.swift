import UIKit
import RxSwift

let disposeBag = DisposeBag()
let fruits = ["π","π","π","π","π"]

// νΉμ  μΈλ±μ€μ μλ κ²λ§ μ νμ μΌλ‘ λ°©μΆνλ μ°μ μμ΄λ€.
// 1λ² μΈλ±μ€μ μλκ²λ§ λ°©μΆνλ μμ 
Observable.from(fruits)
    .element(at: 1)
    .subscribe {print($0)}
    .disposed(by: disposeBag)
