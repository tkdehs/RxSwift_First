import UIKit
import RxSwift

let disposeBag = DisposeBag()


// 1~10 까지 0.3초마다 방출
// 1초대기
// 11~20 까지 0.5초마다 방출
let buttonTap = Observable<String>.create{ observer in
    DispatchQueue.global().async {
        for i in 1...10 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        Thread.sleep(forTimeInterval: 1)
        for i in 11...20 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        observer.onCompleted()
        
    }
    return Disposables.create {
        
    }
}


// debounce는 파라미터로 전달된 시간안에 전달된 next이벤트는 구독자에게 전달되지 않는다.
// debounce는 보통 검색기능을 구현할 떄 사용된다. 짧은 시간동안 타이핑할떄는 검색되지 않다가
// 입력을 다 한 뒤 대기하는 시간이 길어지면 검색프로세스가 실행되야 되는경우 유용하게 사용할 수 있다.
buttonTap
    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
