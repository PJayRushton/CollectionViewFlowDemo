# CollectionViewFlowDemo
An example of using UICollectionViewFlowLayout to make grid style layouts

## Instructions
1. Create a new single view project

### Initial UI Setup
1. Add a `UICollectionView` to the viewController
2. Embed that collection view in a `UIStackView` (vertical, fill)
3. Constrain the stack view to the superview
4. Add an outlet to the VC
5. Connect the datasource and delegate

### Create a UICollectionViewCell subclass
1. Create a subclass of `UICollectionViewCell`
2. Name it `ColorCollectionViewCell`
3. Check the box that says also create XIB
4. Add one `UIView` subview and constrain it to all 4 sides of the cell
5. Add a `UILabel` and constrain it to be centered in the cell
6. Add  connections to both the view and the label
7. In the code file, create a function that is called: `update(with color: UIColor, index: Int)`
8. Set the subview’s background color to the color passed in and the text of the label to be a string of the index

### UICollectionView Datasource + Delegate
1. Register the NIB of the UICollectionViewCell
2. Implement the required datasource functions
3. -> [UICollectionViewDataSource - UIKit | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)
4. Set the number of items in section to ~100
5. Dequeue the ColorCell in `cellForItem`
6. Use the update function of the cell
7. Color cells based on being on even/odd index
8. Implement `didSelectItem`
9. Print the `indexPath.item` of the cell

### UICollectionViewFlowLayout + Delegate
1. Create a flowLayout object
2. -> [UICollectionViewDelegateFlowLayout - UIKit | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout)
3. Set the `collectionView.collectionViewLayout` equal to that layout
4. Set the `minimumLineSpacing` and `minimumInteritemSpacing` on the layout object to be 0
5. Adhere to the `UICollectionViewDelegateFlowLayout` in the VC
6. Implement `sizeForItem` function
7. Calculate the size of the items so it makes 2 x 2 squares that scroll
8. Build and Run

### Sliders
1. Add a slider and label to the stackView (above or below)
2. Embed the label and slider into a stackView
3. Duplicate the stack view 3x
4. Change the labels to say 1. Columns, 2. Rows, 3. Item Spacing, 4. Line Spacing
5. Change the slider min and max as follows:
	1. Columns: 1 - 8,
	2. Rows:  2 - 8
	3. item Spacing: 0 - 36
	4. Line Spacing: 0 - 36
	5. Default values for each anywhere between the min and max
6. Connect actions to the sliders on `valueChanged`
7. Create 3 vars -> 1. `numberOfRows` (Int), 2. `numberOfRows` (Int), 3. `itemSpacing` (CGFloat)
8. Add a `didSet` on each var
9. For now, just print the value in the didSet
10. When each slider changes, set the corresponding property
11. Build and Run

### Adjust Layout at runtime
1. Add a function called `animateLayoutChange`
2. Invalidate the collectionVIew layout in this function
3. Call `animateLayoutChange` from each didSet
4. Manipulate the sizeForItem so it properly calculates item size based on the stored properties

```Swift
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // HEIGHT
        // Get number of inter LINE spaces (vertical)
        let numberofLineSpaces = CGFloat(numberOfRows - 1)
        // Calculate total space between lines
        let totalLineSpacing = flowLayout.minimumLineSpacing * numberofLineSpaces
        // Item height is the total collectionView height - spaces / number of rows
        let itemHeight = (collectionView.bounds.height - totalLineSpacing) / CGFloat(numberOfRows)

        // WIDTH
        let numberOfItemSpaces = CGFloat(numberOfColumns - 1)
        let totalItemSpacing = itemSpacing * numberOfItemSpaces
        let totalWidthMinusSpacing = collectionView.bounds.width - totalItemSpacing
        let itemWidth = totalWidthMinusSpacing / CGFloat(numberOfColumns)

        return CGSize(width: itemWidth, height: itemHeight)
    }
```

5. Wrap the layout invalidation in a `performBatchUpdates` block for cool animations.
