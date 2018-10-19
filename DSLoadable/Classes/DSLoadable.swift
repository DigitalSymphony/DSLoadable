//Copyright (c) 2018 MaherKSantina <maher.santina90@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import Foundation
import MSAutoView

/// Defines the structure of a loading view configuration. The first argument is the view that needs to be loaded. The second argument is the loading view
public typealias DSLoadableConfiguration = (UIView, UIView) -> Void
/// Defines the structure where the view that needs to be loaded is passed as an argument, and the returned view is the loading view
public typealias DSLoadingViewFromConfiguration = (UIView) -> UIView

/// Holds default values and implementations for DSLoadable
public struct DSDefaults {
    /// A default configuration which places the default loading view and sets the foreground and background colors accordingly.
    static let buttonConfiguration: DSLoadableConfiguration = {
        selfView, loadingView in
        guard let lView = loadingView as? DSLoadingView, let selfButton = selfView as? UIButton else {
            return
        }
        lView.layer.cornerRadius = selfButton.layer.cornerRadius
        lView.clipsToBounds = selfButton.clipsToBounds
        lView.indicatorView.color = selfButton.titleColor(for: .normal)
        lView.indicatorView.backgroundColor = selfButton.backgroundColor
    }
}
/// Specifies a way to handle a loading view
public protocol DSLoadable {
    /*
     Will be called when the view should show a loading
     - parameter configuration: The closure that will contain the initialization and configuration for the loading view
     */
    func loadableStartLoading(configuration: DSLoadingViewFromConfiguration)
    /*
     Will be called when the view should show a loading
     - parameter loadingViewType: The type of the loading view
     - parameter configuration: The closure that will contain the configuration for the loading view
     */
    func loadableStartLoading(loadingViewType: UIView.Type, configuration: DSLoadableConfiguration?)
    /*
     Will be called when the view should hide the loading view
     - parameter loadingViewType: The type of the loading view
     - parameter configuration: The closure that will contain the configuration for the loading view before it's removed from the hierarchy
     */
    func loadableStopLoading(loadingViewType: UIView.Type, configuration: DSLoadableConfiguration?)
}

/// Defines the ability to store the loading view type and the configuration. Classes can implement this protocol and will get default implementation for the DSLoadable protocol which makes use of the variables in it
public protocol DSLoadableConfigurable {
    /// The type of the loading view
    var loadableLoadingViewType: UIView.Type { get }
    /// The configuration closure that will be executed on the loading view
    var loadableConfiguration: DSLoadableConfiguration? { get }
}

extension DSLoadable where Self: UIButton {
    public func loadableStartLoading() {
        return loadableStartLoading(loadingViewType: DSLoadingView.self, configuration: DSDefaults.buttonConfiguration)
    }
    
    public func loadableStopLoading() {
        return loadableStopLoading(loadingViewType: DSLoadingView.self)
    }
}

extension DSLoadable where Self: UIView {
    public func loadableStartLoading(loadingViewType: UIView.Type = DSLoadingView.self, configuration: ((UIView, UIView) -> Void)? = nil) {
        var loadingView = subviews.first(where: { type(of: $0) == loadingViewType })
        if loadingView == nil {
            loadingView = loadingViewType.init()
        }
        guard let v = loadingView else {
            return
        }
        configuration?(self, v)
        addSubviewWithConstraints(v)
    }
    
    public func loadableStartLoading(configuration: DSLoadingViewFromConfiguration) {
        let view = configuration(self)
        addSubviewWithConstraints(view)
    }
    
    public func loadableStopLoading(loadingViewType: UIView.Type = DSLoadingView.self, configuration: DSLoadableConfiguration? = nil) {
        guard let loadingView = subviews.first(where: { type(of: $0) == loadingViewType }) else {
            return
        }
        configuration?(self, loadingView)
        loadingView.removeFromSuperview()
    }
}

extension DSLoadable where Self: UIView, Self: DSLoadableConfigurable {
    public func loadableStartLoading() {
        return loadableStartLoading(loadingViewType: loadableLoadingViewType, configuration: loadableConfiguration)
    }
    
    public func loadableStopLoading() {
        return loadableStopLoading(loadingViewType: loadableLoadingViewType)
    }
}

extension UIView: DSLoadable {  }
