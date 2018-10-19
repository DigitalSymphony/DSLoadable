# DSLoadable

![dsloadabledemo](https://user-images.githubusercontent.com/24646608/47226902-59bcaa00-d40d-11e8-82a0-0b3947749d06.gif)

## Intro
To give the user a great user experience, we need to use non-blocking loaders for almost every element that does some asynchronous work. We tend to avoid handling this type of loading by blocking the whole view with a big loader. We don't want to manually add a loading view for each subview in the view controller, and managing them would be very hard. This repo provides fully customizable functions and methods which allows you to easily show loaders for any UIView. You can also plug in your favorite loading animation from another project!

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DSLoadable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DSLoadable'
```

## Features
This repo provides a protocol which has default extension implementation for all views
```swift
public protocol DSLoadable {
    func loadableStartLoading(loadingViewType: UIView.Type, configuration: DSLoadableConfiguration?)
    func loadableStopLoading(loadingViewType: UIView.Type)
}
```
- `loadingViewType`: The view type of the loader that will be shown over the view
- `configuration`: You can manipulate the loading view in this function before placing it in the hierarchy

### Showing the default loader for a button
![buttondefaultloading](https://user-images.githubusercontent.com/24646608/47221243-9bdeef00-d3ff-11e8-9128-f00562ad6231.gif)

If you want to use a simple loader with nothing fancy, you can use the built in one in the library. The above functionality can be implemented like this:

```swift
@IBOutlet weak var submitButton: UIButton!

@IBAction func submitDidPress(_ sender: Any?){
    submitButton.loadableStartLoading()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.submitButton.loadableStopLoading()
    }
}
```

This loader automatically takes the text color and the background color of the button and updates the loading view accordingly. This configuration is declared `public static` in `DSDefaults` struct and you can use it for other things
```swift
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
```
### Adding a custom Loading View
![buttoncustomloading](https://user-images.githubusercontent.com/24646608/47223536-3b52b080-d405-11e8-927c-ce3c7bc685d5.gif)

You can integrate any loading view/library to the logic. In the above example, I'm using the awesome [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView) which has a lot of amazing animations. The above example can be implemented using this code:

```swift
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
```
It's important to note that there are 2 versions for `loadableStartLoading` function:

```swift
func loadableStartLoading(loadingViewType: UIView.Type, configuration: DSLoadableConfiguration?)
```
When you pass the `loadingViewType` for this function, the `DSLoadable` extension will automatically initialize the view type by calling `init(frame:)` and then adding it with constraints into the view hierarchy. In the above example, the `NVActivityIndicatorView` doesn't have an implemnetation for `init(frame:)`. So, it will crash if we try to use this function. To solve this problem, we are using the function below.

```swift
func loadableStartLoading(configuration: DSLoadingViewFromConfiguration)
```
This function takes a configuration closure. This closure will return a `UIView` which will be added to the view hierarchy. In this way, we can call the custom initialization function for the `NVActivityIndicatorView` (`init(frame:,type:,color:,padding:)`) and return the final view from the closure. After the closure is executed, the `NVActivityIndicatorView` will automatically be added in the view hierarchy with constraints

### Showing a loader for any view
Showing a loader for a `UIView` works exactly the same as showing the loader for a `UIButton`. You can use the default loader provided or you can add your custom one.

## Author

MaherKSantina, maher.santina90@gmail.com

## License

DSLoadable is available under the MIT license. See the LICENSE file for more info.
