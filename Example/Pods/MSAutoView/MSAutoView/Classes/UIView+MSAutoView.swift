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

public typealias ConstraintsConfiguration = (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) -> Void

extension UIView {
    /**
     Embeds a view inside another view and adds constraints to fit the subview in the whole view
     - Parameter subview: The subview that will be added
     */
    public func addSubviewWithConstraints(_ subview: UIView, constraintsConfiguration: ConstraintsConfiguration? = nil){
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let viewConstraints = [NSLayoutAttribute.top, NSLayoutAttribute.left, NSLayoutAttribute.bottom, NSLayoutAttribute.right].map { (attribute) -> NSLayoutConstraint in
            return NSLayoutConstraint(item: subview, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1, constant: 0)
        }
        
        addSubview(subview)
        addConstraints(viewConstraints)
        constraintsConfiguration?(viewConstraints[0], viewConstraints[1], viewConstraints[2], viewConstraints[3])
    }
}
