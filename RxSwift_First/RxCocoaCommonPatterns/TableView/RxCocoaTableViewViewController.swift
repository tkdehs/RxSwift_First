//
//  RxCocoaTableViewViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/26.
//

import UIKit
import RxCocoa
import RxSwift

class RxCocoaTableViewViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    let bag = DisposeBag()
    
    let nameObservable = Observable.of(appleProducts.map{$0.name})
    
    let productObservable = Observable.of(appleProducts)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(UINib(nibName: ProductCell.id, bundle: nil), forCellReuseIdentifier: ProductCell.id)

//        nameObservable.bind(to: listTableView.rx.items) {
//            tableView, row, element in
//            let cell = UITableViewCell()
//            cell.textLabel?.text = element
//            return cell
//        }.disposed(by: bag)
        
        productObservable
            .subscribe(on: MainScheduler.instance)
            .bind(to: listTableView.rx.items(cellIdentifier: ProductCell.id ,cellType: ProductCell.self)) {
                row, element, cell in
                cell.lbCategory.text = element.category
                cell.lbProduct.text = element.name
                cell.lbSummary.text = element.summary
                cell.lbPrice.text = self.priceFormatter.string(for: element.price)
            }
            .disposed(by: bag)
        
//        listTableView.rx.modelSelected(Product.self)
//            .subscribe(onNext: {
//                product in
//                print(product.name)
//            })
//            .disposed(by: bag)
//
//        listTableView.rx.itemSelected
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: {
//                indexPath in
//                self.listTableView.deselectRow(at: indexPath, animated: true)
//            })
//            .disposed(by: bag)
        
        // ??? ???????????? ?????? ?????? ????????? ???????????? ????????????????????? zip??? ???????????? ???????????? ?????? ????????????.
        Observable.zip(listTableView.rx.modelSelected(Product.self), listTableView.rx.itemSelected)
            .bind {
                product, indexPath in
                self.listTableView.deselectRow(at: indexPath, animated: true)
                print(product.name)
            }
            .disposed(by: bag)
        
        // cocoatouch??? ???????????? ???????????? rx??? ???????????? ???????????? ?????????.
//        listTableView.delegate = self
        // ????????? ?????? ???????????? ??????.
        
        listTableView.rx.setDelegate(self).disposed(by: bag)
    }
}

extension RxCocoaTableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
