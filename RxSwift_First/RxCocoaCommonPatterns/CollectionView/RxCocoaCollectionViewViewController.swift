//
//  RxCocoaCollectionViewViewController.swift
//  RxSwift_First
//
//  Created by PNX on 2022/05/27.
//

import UIKit
import RxCocoa
import RxSwift

class RxCocoaCollectionViewViewController: UIViewController {

    @IBOutlet weak var cvView: UICollectionView!
    
    let bag = DisposeBag()
    
    let colorObservable = Observable.of(MaterialBlue.allColors)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvView.register(UINib(nibName: ColorCell.id, bundle: nil), forCellWithReuseIdentifier: ColorCell.id)
        
        colorObservable.bind(to: cvView.rx.items(cellIdentifier: ColorCell.id, cellType: ColorCell.self)) {
            index, color, cell in
            cell.backgroundColor = color
            cell.lbColor.text = color.rgbHexString
        }.disposed(by: bag)
        
        Observable.zip(cvView.rx.itemSelected, cvView.rx.modelSelected(UIColor.self))
            .bind {
                index, color in
                print(color.rgbHexString)
            }.disposed(by: bag)
        
        cvView.rx.setDelegate(self).disposed(by: bag)
    }

}


extension RxCocoaCollectionViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let value = (collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing)) / 2
        return CGSize(width: value, height: value)
    }
}
