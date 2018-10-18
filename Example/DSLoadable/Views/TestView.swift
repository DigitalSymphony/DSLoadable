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

class TestView: MSAutoView {
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitDidPress(_ sender: Any?){
        loadableViewStartLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadableViewStopLoading()
        }
    }

}

extension TestView: DSLoadable {
    
    func loadableView(_ loadableView: UIView, configureLoadingView loadingView: UIView) {
        guard let lView = loadingView as? LoadingView else {
            return
        }
        lView.layer.cornerRadius = submitButton.layer.cornerRadius
        lView.clipsToBounds = submitButton.clipsToBounds
        lView.indicatorView.color = submitButton.titleColor(for: .normal)
        lView.indicatorView.backgroundColor = submitButton.backgroundColor
    }
}
