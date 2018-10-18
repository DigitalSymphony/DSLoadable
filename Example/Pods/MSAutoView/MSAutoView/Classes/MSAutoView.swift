/**
 MIT License
 
 Copyright (c) 2018 MaherKSantina
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

public typealias XibItemsConfiguration = ([Any]?) -> Void

public protocol MSXibEmbedding: AnyObject {
    var xibBundle: Bundle? { set get  }
    var xibName: String? { set get }
    
    func loadXibMainView(constraintsConfiguration: ConstraintsConfiguration?)
    func loadXibItems(xibItemsConfiguration: XibItemsConfiguration?)
}

extension MSXibEmbedding where Self: UIView {
    
    public func loadXibMainView(constraintsConfiguration: ConstraintsConfiguration? = nil) {
        loadXibItems { (xibItems) in
            let view = xibItems?[0] as! UIView
            self.addSubviewWithConstraints(view, constraintsConfiguration: constraintsConfiguration)
        }
    }
    
    public func loadXibItems(xibItemsConfiguration: XibItemsConfiguration? = nil) {
        let items = (self.xibBundle ?? Bundle(for: type(of: self))).loadNibNamed(self.xibName ?? String(describing: type(of: self)), owner: self, options: nil)
        xibItemsConfiguration?(items)
    }
}

open class MSAutoView: UIView, MSXibEmbedding {
    
    public var xibBundle: Bundle?
    public var xibName: String?
    public weak var tableViewCell: UITableViewCell?
    public weak var collectionViewCell: UICollectionViewCell?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    open func initView(constraintsConfiguration: ConstraintsConfiguration? = nil) {
        loadXibMainView(constraintsConfiguration: constraintsConfiguration)
    }
    
    open func initView() {
        initView(constraintsConfiguration: nil)
    }
    
    open func updateView() {
        //Override
    }
    
    open func updateEmptyView() {
        //Override
    }
    
}

