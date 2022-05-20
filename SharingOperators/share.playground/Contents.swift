import UIKit
import RxSwift

let bag = DisposeBag()

// 가장 기본적인 공유 형태
// share를 설정하면 하나의 옵저버블을 공유하기때문에 여러번 구독해도 이벤트는 한번만 실행되게 된다.
let source = Observable<String>.create { observer in
    let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data, let html = String(data: data, encoding: .utf8) {
            observer.onNext(html)
        }
        
        observer.onCompleted()
    }
    task.resume()
    return Disposables.create {
        task.cancel()
    }
}
.debug()
.share()

source.subscribe().disposed(by: bag)
source.subscribe().disposed(by: bag)
source.subscribe().disposed(by: bag)
