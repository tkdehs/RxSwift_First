import UIKit
import RxSwift

let disposeBag = DisposeBag()
let skills = ["Swift", "SwiftUI", "RxSwift"]

// 요소들을 편집해서 구독자에게 전달한다.
// 편집된 요소가 원본 데이터타입과 같을필요는 없다. string이아닌 int로 변환하여 전달 가능하다.
Observable.from(skills)
//    .map {"Hello, \($0)"}
    .map { $0.count }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
