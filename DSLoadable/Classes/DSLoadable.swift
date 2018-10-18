//
//  DSLoadable.swift
//  DSLoadable
//
//  Created by Maher Santina on 10/14/18.
//

import Foundation
import MSAutoView

extension UIView {
    public func startLoading(loadingViewType: UIView.Type = LoadingView.self, configuration: ((UIView, UIView) -> Void)?) {
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
    
    public func stopLoading(loadingViewType: UIView.Type = LoadingView.self) {
        let loadingView = subviews.first(where: { type(of: $0) == loadingViewType })
        loadingView?.removeFromSuperview()
    }
}

public protocol DSLoadableDelegate {
    func loadableShouldStartLoading(_ loadableView: UIView)
    func loadableShouldStopLoading(_ loadableView: UIView)
    func loadable(_ loadableView: UIView, configureLoadingView loadingView: UIView)
}

extension DSLoadableDelegate {
    public func loadableShouldStartLoading(_ loadableView: UIView) {
        let loadingView = loadableSuperviewForLoading(loadableView).subviews.first(where: { type(of: $0) == loadingViewTypeFor(loadableView) })
        loadingView?.removeFromSuperview()
    }
    
    public func loadableShouldStopLoading(_ view: UIView) {
        var loadingView = loadableSuperviewForLoading(view).subviews.first(where: { type(of: $0) == loadingViewTypeFor(view) })
        if loadingView == nil {
            loadingView = loadingViewTypeFor(view).init()
        }
        loadable(view, configureLoadingView: loadingView!)
        loadableSuperviewForLoading(view).addSubviewWithConstraints(loadingView!)
    }
    
    public func loadingViewTypeFor(_ loadableView: UIView) -> UIView.Type {
        return LoadingView.self
    }
    
    public func loadable(_ loadableView: UIView, configureLoadingView loadingView: UIView) {
        
    }
    
    public func loadableSuperviewForLoading(_ loadableView: UIView) -> UIView {
        return loadableView
    }
}

public protocol DSLoadable {
    func loadableViewStartLoading()
    func loadableViewStopLoading()
    func loadingViewTypeFor(_ loadableView: UIView) -> UIView.Type
    func loadableViewSuperviewForLoading(_ loadableView: UIView) -> UIView
    func loadableView(_ loadableView: UIView, configureLoadingView loadingView: UIView)
}

extension DSLoadable {
    public func loadingViewTypeFor(_ loadableView: UIView) -> UIView.Type {
        return LoadingView.self
    }
    
    public func loadableView(_ loadableView: UIView, configureLoadingView loadingView: UIView) {
        
    }
}

extension DSLoadable where Self: UIView {
    public func loadableViewStopLoading() {
        let loadingView = loadableViewSuperviewForLoading(self).subviews.first(where: { type(of: $0) == loadingViewTypeFor(self) })
        loadingView?.removeFromSuperview()
    }
    
    public func loadableViewStartLoading() {
        var loadingView = loadableViewSuperviewForLoading(self).subviews.first(where: { type(of: $0) == loadingViewTypeFor(self) })
        if loadingView == nil {
            loadingView = loadingViewTypeFor(self).init()
        }
        loadableView(self, configureLoadingView: loadingView!)
        loadableViewSuperviewForLoading(self).addSubviewWithConstraints(loadingView!)
    }
    
    public func loadableViewSuperviewForLoading(_ loadableView: UIView) -> UIView {
        return self
    }
}
