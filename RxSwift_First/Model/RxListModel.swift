
import RxDataSources
import Foundation
import UIKit

public typealias MySection = SectionModel<String,RxListModel>

public struct RxListModel{
    var strTitle: String
    var viewController : UIViewController
}

extension RxListModel : IdentifiableType {
    public var identity: String {
        return UUID().uuidString
    }
}
