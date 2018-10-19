//
//  TestView.swift
//  MSLoadable
//
//  Created by Maher Santina on 10/13/18.
//  Copyright © 2018 Maher Santina. All rights reserved.
//

import UIKit
import MSAutoView
import DSLoadable
import NVActivityIndicatorView

class TestView: MSAutoView {
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitDidPress(_ sender: Any?){
        submitButton.loadableStartLoading { (selfView) -> UIView in
            let activityView = NVActivityIndicatorView(frame: submitButton.bounds, type: .lineScale, color: UIColor.white, padding: 12)
            activityView.backgroundColor = submitButton.backgroundColor
            activityView.startAnimating()
            return activityView
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.submitButton.loadableStopLoading(loadingViewType: NVActivityIndicatorView.self, configuration: {
                selfView, loadingView in
                guard let v = loadingView as? NVActivityIndicatorView else {
                    return
                }
                v.stopAnimating()
            })
        }
    }

}
