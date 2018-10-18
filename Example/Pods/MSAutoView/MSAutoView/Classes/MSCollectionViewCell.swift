//
//  MSCollectionViewCell.swift
//  MSAutoView
//
//  Created by Maher Santina on 8/11/18.
//

import UIKit

open class MSCollectionViewCell<T: MSAutoView>: UICollectionViewCell {
    public var mainView = T()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        mainView.collectionViewCell = self
    }
}

public protocol CollectionViewCellContainable {
    associatedtype CollectionViewCellContainedViewType: MSAutoView
    
    static var collectionViewCell: MSCollectionViewCell<CollectionViewCellContainedViewType>.Type { get }
}

extension CollectionViewCellContainable where Self: MSAutoView {
    
    public static var collectionViewCell: MSCollectionViewCell<Self>.Type {
        return MSCollectionViewCell<Self>.self
    }
}

extension MSAutoView: CollectionViewCellContainable { }
