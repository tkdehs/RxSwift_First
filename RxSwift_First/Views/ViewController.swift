//
//  ViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController, UITableViewDelegate {

    var tvList = UITableView()
    var viewModel = RxModel()
    
    var dataSource = RxTableViewSectionedReloadDataSource<MySection> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: RxTableViewCell.identify, for: indexPath) as! RxTableViewCell
        cell.bind(data: item)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        setBridge()
        setSections()
    }
    
    func setTable(){
        self.view.addSubview(tvList)
        tvList.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaInsets)
        }
        
        tvList.register(UINib(nibName: RxTableViewCell.identify, bundle: nil), forCellReuseIdentifier: RxTableViewCell.identify)
        
        dataSource.titleForHeaderInSection = {
            dataSource , index in
            return dataSource.sectionModels[index].model
        }
        
        // delegate 설정
        tvList.rx.setDelegate(self)
            .disposed(by: viewModel.bag)
        
        // select event 설정
        tvList.rx.modelSelected(MySection.Item.self)
            .subscribe{
                if let vc = $0.element?.viewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }.disposed(by: viewModel.bag)
    }
    
    func setSections() {
        var sections:[MySection] = []
        var section1Items:[RxListModel] = []
        section1Items.append(RxListModel(strTitle: "Hello RxCocoa", viewController: HelloRxCocoaViewController()))
        section1Items.append(RxListModel(strTitle: "Binding RxCocoa", viewController: BindingRxCocoaViewController()))
        section1Items.append(RxListModel(strTitle: "Traits RxCocoa", viewController: TraitsViewController()))
        section1Items.append(RxListModel(strTitle: "Driver RxCocoa", viewController: DriverViewController()))
        
        let section1 = MySection(model: "RxCocoa", items: section1Items)
        sections.append(section1)
        viewModel.tableSubject.accept(sections)
    }
    
    func setBridge(){
        viewModel.tableSubject
            .bind(to: tvList.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.bag)
        
    }
    
}


extension UIControl {
    
    /// 타겟 추가
    ///
    /// - Parameters:
    ///   - controlEvents: 컨트롤 이벤트
    ///   - action: 액션
    func addTarget (controlEvents: UIControl.Event = .touchUpInside, action: @escaping ()->()) {
        let sleeve = ClosureSleeve(action)
         addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    class ClosureSleeve {
        let closure: ()->()
        
        init (_ closure: @escaping ()->()) {
            self.closure = closure
        }
        
        @objc func invoke () {
            closure()
        }
    }
}
