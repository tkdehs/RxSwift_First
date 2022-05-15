import UIKit
import RxSwift

let disposeBag = DisposeBag()

let subject = PublishSubject<String?>()

// 변환결과가 nil이면 방출하지 안는다.
// 변환결과가 optional이면 언래핑하여 방출한다.
subject
    .compactMap({ str in
        str
    })
    .subscribe { print($0) }
    .disposed(by: disposeBag)

Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
    .take(10)
    .map{ _ in Bool.random() ? "🪱" : nil }
    .subscribe(onNext: {subject.onNext($0)})
    .disposed(by: disposeBag)
