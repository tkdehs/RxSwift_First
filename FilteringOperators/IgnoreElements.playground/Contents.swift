import UIKit
import RxSwift

let disposeBag = DisposeBag()
let fruits = ["๐","๐","๐","๐","๐"]


// ignoreElements ๋ error์ completed๋ง ๋ฐฉ์ถํ๋ค.
// ์ต์ ๋ฒ๋ธ์ด ์ฑ๊ณต์ด๋ ์คํจ๋๋ง ํ๋จํด์ ํํฐ๋งํ๋ ์ฐ์ฐ์์ด๋ค.
// RxSwift5 ์์๋ ignoreElements ๊ฐ Completable์ ๋ฆฌํดํ๋ค.
// RxSwift6 ๋ถํด ignoreElements ๊ฐ Observable<Never>์ ๋ฆฌํดํ๋ค.
Observable.from(fruits)
    .ignoreElements()
    .subscribe { str in
        print(str)
    }
    .disposed(by: disposeBag)

