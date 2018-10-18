//
//  MSTableViewCell<T>.swift
//  MSAutoView
//
//  Created by Maher Santina on 8/10/18.
//

import UIKit

open class MSTableViewCell<T: MSAutoView>: UITableViewCell {
    
    public var mainView = T()
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    public func initView() {
        mainView.removeFromSuperview()
        contentView.addSubviewWithConstraints(mainView)
        backgroundColor = mainView.backgroundColor
        mainView.tableViewCell = self
    }
}


public protocol TableViewCellContainable {
    associatedtype TableViewCellContainedViewType: MSAutoView
    
    static var tableViewCell: MSTableViewCell<TableViewCellContainedViewType>.Type { get }
}

extension TableViewCellContainable where Self: MSAutoView {
    
    public static var tableViewCell: MSTableViewCell<Self>.Type {
        return MSTableViewCell<Self>.self
    }
}

extension MSAutoView: TableViewCellContainable { }
