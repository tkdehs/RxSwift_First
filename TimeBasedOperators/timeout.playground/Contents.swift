import UIKit
import RxSwift

let bag = DisposeBag()
let subject = PublishSubject<Int>()

// 첫번째 파라미터로 타임아웃 주기설정
// 두번째 파라미터로 타임아웃시 전달될 옵저버블 설정 설정하지 않을경우 error 이벤트가 그대로 전달된다.
subject.timeout(.seconds(3), other: Observable.just(999), scheduler: MainScheduler.instance)
    .subscribe {print($0) }
    .disposed(by: bag)

Observable<Int>.timer(.seconds(1), period: .seconds(5), scheduler: MainScheduler.instance)
    .subscribe(onNext: { subject.onNext($0) })
    .disposed(by: bag)
