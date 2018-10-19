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

