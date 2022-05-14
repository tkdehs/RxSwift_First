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
// throttle은 파리미터로 전달받은 시간이경과되면 그안에 실행됬던 마지막 이벤트를 구독자에게 전달한다.
// 그래서 debounce와는 다르게 1초마다 이벤트가 전달된다.
//buttonTap
//    .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)


func currentTimeString() -> String {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}

//Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//    .debug() // 이벤트 결과 시간을 알기위해 추가
//    .take(10)
//    .throttle(.milliseconds(2500), latest: true, scheduler: MainScheduler.instance)
//    .subscribe{ print(currentTimeString(), $0) }
//    .disposed(by: disposeBag)

// latest 가 false이면 파라미터로 전달된 시간이 끝나고 처음 전달받은 이벤트가 실핼된다.
// latest 가 true 이면 지정된시간을 엄격하게 지켜 그시간에 이벤트가 실행하지만
// false 일경우 그 시간을 넘겨서 이벤트가 실행 될 수 있다.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .take(10)
    .throttle(.milliseconds(2500), latest: false, scheduler: MainScheduler.instance)
    .subscribe{ print(currentTimeString(), $0) }
    .disposed(by: disposeBag)
