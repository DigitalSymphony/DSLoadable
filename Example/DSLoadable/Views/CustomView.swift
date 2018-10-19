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
import MSAutoView
import DSLoadable
import NVActivityIndicatorView

class CustomView: MSAutoView {
    
    enum LoadingType {
        case normal
        case custom
    }
    
    @IBOutlet weak var submitButton: UIButton!
    
    var loadingType: LoadingType = .normal
    
    
    @IBAction func submitDidPress(_ sender: Any?){
        switch loadingType {
        case .normal:
            loadableStartLoading()
        case .custom:
            loadableStartLoading { (selfView) -> UIView in
                let activityView = NVActivityIndicatorView(frame: submitButton.bounds, type: .lineScale, color: UIColor.white, padding: 12)
                activityView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 0.5)
                activityView.startAnimating()
                return activityView
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            switch self.loadingType {
            case .normal:
                self.loadableStopLoading()
            case .custom:
                self.loadableStopLoading(loadingViewType: NVActivityIndicatorView.self, configuration: {
                    selfView, loadingView in
                    guard let v = loadingView as? NVActivityIndicatorView else {
                        return
                    }
                    v.stopAnimating()
                })
            }
            
        }
    }

}
