//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Parker Rushton on 3/11/17.
//  Copyright © 2017 Parker Rushton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    
    fileprivate var numberOfColumns: Int = 4 {
        didSet {
            animateLayoutChange()
        }
    }
    fileprivate var numberOfRows: Int = 4 {
        didSet {
            animateLayoutChange()
        }
    }
    fileprivate var itemSpacing: CGFloat = 16 {
        didSet {
            animateLayoutChange()
        }
    }
    fileprivate var lineSpacing: CGFloat = 8 {
        didSet {
            animateLayoutChange()
        }
    }
    
    fileprivate let flowLayout = UICollectionViewFlowLayout()

    
    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = flowLayout
    }

    
    // MARK: - IBActions

    @IBAction func columnsSliderValueChanged(_ sender: UISlider) {
        numberOfColumns = Int(sender.value)
    }
    
    @IBAction func rowsSliderValueChanged(_ sender: UISlider) {
        numberOfRows = Int(sender.value)
    }
    
    @IBAction func itemSpacingSliderValueChanged(_ sender: UISlider) {
        itemSpacing = CGFloat(sender.value)
    }

    @IBAction func lineSpacingSliderChanged(_ sender: UISlider) {
        lineSpacing = CGFloat(sender.value)
    }
    
}


// MARK: - Private

extension ViewController {
    
    fileprivate func animateLayoutChange() {
        collectionView.performBatchUpdates({
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
}


// MARK: - CollectionView DataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "simpleCell", for: indexPath)
        let color = indexPath.item % 2 == 0 ? .blue : UIColor.gray
        cell.backgroundColor = color
        
        return cell
    }
    
}


// MARK: - CollectionView Delegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("I SELECTED THE ITEM AT INDEX PATH: \(indexPath)")
    }
    
}


// MARK: - FlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // HEIGHT
        // Get number of inter LINE spaces (vertical)
        let numberofLineSpaces = CGFloat(numberOfRows - 1)
        // Calculate total space between lines
        let totalLineSpacing = lineSpacing * numberofLineSpaces
        // Item height is the total collectionView height - spaces / number of rows
        let itemHeight = (collectionView.bounds.height - totalLineSpacing) / CGFloat(numberOfRows)
        
        // WIDTH
        let numberOfItemSpaces = CGFloat(numberOfColumns - 1)
        let totalItemSpacing = itemSpacing * numberOfItemSpaces
        let totalWidthMinusSpacing = collectionView.bounds.width - totalItemSpacing
        let itemWidth = totalWidthMinusSpacing / CGFloat(numberOfColumns)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
}
