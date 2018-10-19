//
//  DSLoadable.swift
//  DSLoadable
//
//  Created by Maher Santina on 10/14/18.
//

import Foundation
import MSAutoView

public typealias DSLoadableConfiguration = (UIView, UIView) -> Void
public typealias DSLoadingViewFromConfiguration = (UIView) -> UIView

public struct DSDefaults {
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

public protocol DSLoadable {
    func loadableStartLoading(configuration: DSLoadingViewFromConfiguration)
    func loadableStartLoading(loadingViewType: UIView.Type, configuration: DSLoadableConfiguration?)
    func loadableStopLoading(loadingViewType: UIView.Type, configuration: DSLoadableConfiguration?)
}

public protocol DSLoadableConfigurable {
    var loadableLoadingViewType: UIView.Type { get }
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
