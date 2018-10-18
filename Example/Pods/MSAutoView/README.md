# MSAutoView

To create an iOS app, you have to deal with ALOT of views. So, managing different views will become painful as the project grows. Sometimes, a single view will be used in multiple places with small variations. You feel that if there's a way to manage every view in one place would save you alot of trouble. Well, this is what MSAutoView does exactly.

# Table of Contents
1. [Installation](#installation)
1. [Prerequisites](#prerequisites)
2. [Usage](#usage)
3. [Structure](#structure)
4. [Customization](#customization)
5. [Deployment](#deployment)
6. [Authors](#authors)
7. [License](#license)

## Installation

MSAutoView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MSAutoView'
```

## Prerequisites

- XCode 9


## Structure
This is an example of how your view files will be structured when using MSAutoView:
![Image](https://user-images.githubusercontent.com/24646608/43649568-d343d6c4-9780-11e8-952b-bf9523f82dbd.png)

Each view will have its own xib file and swift file. The xib file will contain the view hierarchy, and the swift file will hold the logic for this view.

`MSAutoView` is a subclass of `UIView`. When creating a class that inherits from `MSAutoView`, it automatically finds the corresponding xib and adds it as a subview. It also creates top, bottom, left and right constraints for the subview to hold it in place.

**Note: The view in the xib should not have constraint ambiguity or it would not show properly**

## Usage
### Minimal Configuration
#### Storyboard

1. Create a xib file and add the reusable view to it (Example):

    ![Image](https://user-images.githubusercontent.com/24646608/34810736-4aba90b6-f6f1-11e7-8765-803c93fd06df.png)

2. Create a swift file and add a class that inherits from `MSAutoView`

```swift
import UIKit
import MSAutoView

class ListingView: MSAutoView {

}
```
**Note: For the minimal configuration to work, the class's name should be the same as the xib's name**

3. In the storyboard, add a normal view to your view controller and set its class to the one created (`ListingView`)
4. Run the project, the view should contain the content of the xib

    ![Image](https://user-images.githubusercontent.com/24646608/34811158-9ee32e80-f6f3-11e7-9645-b488647af327.png)
    
## Customization
### Updating View Programmatically

Ofcourse, the reusable view will be useless if you can't pass data to it programmatically. To do that, follow the steps below:

1. Set the xib `File's Owner` class to the class created previously

2. Add outlets to the class:

```swift
class ListingView: MSAutoView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}
```

3. In the xib file, connect the outlets to their respective views

5. In the view controller, create an outlet for the view

```swift
@IBOutlet weak var listingView: ListingView!
```

6. Connect the view controller's outlet to the view in the storyboard

7. Change the text values of the labels in the view controller:

```swift
listingView.titleLabel.text = "This is a default title"
listingView.detailsLabel.text =  "This is a default details"
listingView.priceLabel.text = "300"
```

### Adding variables to update the view
It's not a good convention to directly update the text in the labels. So, you can create variables to hold the values, and update the view when you change the values. To do that, follow the steps below:

1. In the `ListingView` class file, add the following variables:

```swift
class ListingView: MSAutoView {
    
    //Outlets
    
    var title: String?
    var details: String?
    var price: String?
}
```
2. Override `updateView()` function to set the label texts:

```swift
class ListingView: MSAutoView {
    
    //Outlets
    
    //Variables
    
    override func updateView() {
        super.updateView()
        titleLabel.text = title
        detailsLabel.text = details
        priceLabel.text = price
    }
}
```
3. Set the values anywhere in the view controller and update the view:

```swift
listingView.title = "This is a default title"
listingView.details =  "This is a default details"
listingView.price = "300"
listingView.updateView()
```

### Using Inspectable variables
You can use inspectable variables to hold the values for the labels:

```swift
class ListingView: MSAutoView {
    
    //Outlets
    
    @IBInspectable var title: String?
    @IBInspectable var details: String?
    @IBInspectable var price: Double = 0
    
    //Functions
}
```

After creating the inspectable variables, you can set them either in the xib or the view controller

### Creating a table view cell from any view
If you want to save the hassle of creating a new cell class for each view that is used in a `UITableView`, you can use the generic class `MSTableViewCell<T>` supplied by the repository. You can use it as follows:
1. Create a table view
2. Register the cell programmatically:

```swift
tableView.register(MSTableViewCell<ListingView>.self, forCellWithReuseIdentifier: "Cell")
```
Alternatively, `MSAutoView` adds an extension to `UIView` which has variables that return a table view cell from any view. So, you can register the cell as such:

```swift
tableView.register(ListingView.tableViewCell.self, forCellWithReuseIdentifier: "Cell")
```
3. In the `tableView(_:cellForRowAt:)`, dequeue the cell with the reuse identifier like this:

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MSTableViewCell<ListingView>
```
4. You can access the encapsulated view using the vairable `mainView` on the cell:

```swift
cell.mainView.doSomething()
```
This class is an `open` class so you can subclass it as you wish to add more features.

### Creating a collection view cell from any view
Creating a collection view cell from any view acts similar as creating a table view cell. But, you would use the extension variable `collectionViewCell` instead of the `tableViewCell`

### Getting the table view cell or collection view cell of any view (If exists)
The `MSAutoView` now has two properties which can be set to be able to retrieve the table view cell/collection view cell later on from the view
```swift
public weak var tableViewCell: UITableViewCell?
public weak var collectionViewCell: UICollectionViewCell?
```
It works similar to the `superView` variable, just set the cell when setting up the view, and in the delegate functions you can retrieve the corresponding cell by calling either `view.tableViewCell` or `view.collectionViewCell`

### Creating a scroll view from any view
Creating a scroll view is the same as creating a table view/collection view. Assuming that you have a tall view of class `TallView` which has a label called `anyLabel`, you can do the following in your view controller
```swift
let tallView = TallView()
tallView.anyLabel.text = "This is a dummy text"
view.addSubviewWithConstraints(tallView.scrollView)
```

### Using a default value for all instances of the view
You can do this in 2 ways:
1. Set the value in code:
```swift
var title: String? = "Default Title"
```
2. If it's an inspectable variable, set the value in the xib file

### Setting defaut value for view in a specific view controller
If your class variables are inspectables, you can change the default values in the storyboard

### Adding padding to the main xib view programmatically
As a recap, the class will embed the xib's view in the main view by adding top, left, bottom and right constraints. To add padding to the constraints, you can set their constant value other than 0. You can do that in the `initView()` function:

```swift
override func initView() {
    super.initView { (top, left, bottom, right) in
        top.constant = 10
        left.constant = 10
        bottom.constant = -10
        right.constant = -10
    }
    updateView()
}
```
Note that the bottom and right constants should be negative to work as intended

Alternatively, you can add paddings later on:
```swift
    fileprivate var leftLayoutConstraint: NSLayoutConstraint?
    fileprivate var rightLayoutConstraint: NSLayoutConstraint?
    
    override func initView() {
        super.initView {[weak self] (top, left, bottom, right) in
            self?.leftLayoutConstraint = left
            self?.rightLayoutConstraint = right
        }
    }

    // update the margin whenever you want.
    func updateMargin(_ left: CGFloat, _ right: CGFloat) {
        self.leftLayoutConstraint?.constant = left
        self.rightLayoutConstraint?.constant = right
    }
```

### Using a xib with name different than class name
If you wish to name your xib something other than the class name, you can do the following:
1. In the class file, override the `initView()` function:

```swift
class ListingView: MSAutoView {

    //Outlets
    
    //Variables
    
    override func initView() {
        self.xibName = "ListingView2"
        super.initView()
    }

}
```

### Using a xib with bundle different than the class bundle

```swift
class ListingView: MSAutoView {

    //Outlets
    
    //Variables
    
    override func initView() {
        self.xibBundle = Bundle(identifier: "Identifier")
        super.initView()
    }

}
```

### Using protocol instead of subclassing
If you inherit from another view and subclassing is not an option, there's a protocol that can be used to easily embed views:

```swift
public protocol MSXibEmbedding: AnyObject {
    var xibBundle: Bundle? { set get  }
    var xibName: String? { set get }
    
    func loadXibMainView(constraintsConfiguration: ConstraintsConfiguration?)
    func loadXibItems(xibItemsConfiguration: XibItemsConfiguration?)
}
```

There's extension functions for the protocol functions so you don't have to worry about the actual implementation. Just make your view conform to the `MSXibEmbedding` protocol and call `loadXibMainView()` when you initialize your view

### Adding a view inside another view with constraints programmatically

You can easily aggregate views by placing them inside each other. You can do that using the `UIView` extension function below:

```swift
public func addSubviewWithConstraints(_ subview: UIView, constraintsConfiguration: ConstraintsConfiguration? = nil)
```

Example:
```swift
parentView.addSubviewWithConstraints(childView)
```

### Using xibs with multiple items
You might want to use a xib which has multiple top level views. Maybe there are also objects other than views. To do that, override the `initView()` as follows:
```swift
override func initView() {
    loadXibItems { (items) in
        //Use xib items here, maybe save them in variables ...
    }
}
```
**Note: If you call `loadXibItems` more than once, the previously loaded xib items will be discarded and the new items will be available. So you might get a `nil` if you try to access a discarded item.**

## Authors

* **Maher Santina** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/MaherKSantina/MSDialogViewController/blob/master/LICENSE) file for details
