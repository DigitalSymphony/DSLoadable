//
//  ViewController.swift
//  DSLoadable
//
//  Created by MaherKSantina on 10/14/2018.
//  Copyright (c) 2018 MaherKSantina. All rights reserved.
//

import UIKit
import DSLoadable

class ViewController: UIViewController {
    
    let defaultConfiguration: (UIView, UIView) -> Void = { (button, loadingView) in
        guard let lView = loadingView as? DSLoadingView else {
            return
        }
        if let buttonView = button as? UIButton {
            lView.layer.cornerRadius = buttonView.layer.cornerRadius
            lView.clipsToBounds = buttonView.clipsToBounds
            lView.indicatorView.color = buttonView.titleColor(for: .normal)
            lView.indicatorView.backgroundColor = buttonView.backgroundColor
        }
    }
    
    @IBOutlet weak var testView: TestView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitDidPress(_ sender: Any?) {
        view.loadableStartLoading()
        submitButton.loadableStartLoading(configuration: defaultConfiguration)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.submitButton.loadableStopLoading()
            self.view.loadableStopLoading()
        }
    }
    
    @IBAction func buttonDidPress(_ sender: Any?) {
        testView.loadableStartLoading()
    }
    
    @IBAction func stopDidPress(_ sender: Any?) {
        testView.loadableStopLoading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

