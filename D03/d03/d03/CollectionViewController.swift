//
//  CollectionViewController.swift
//  d03
//
//  Created by Sydney COHEN on 5/31/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var allimages = images
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewcontrollersegue") {
            if let vc = segue.destination as? ViewController {
                let indexPath = sender as! IndexPath;
                let imageCell = collectionView?.cellForItem(at: indexPath) as! CollectionViewCell
                
                vc.title = "Image";
                vc.lookupImage = imageCell.imageView.image;
            }
        }
    }
    
    @objc func tapDetected(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.collectionView);
        let indexPath = self.collectionView?.indexPathForItem(at: tapLocation);
        let imageCell = collectionView?.cellForItem(at: indexPath!) as! CollectionViewCell
        
        if (imageCell.imageView.image != nil) {
            performSegue(withIdentifier: "viewcontrollersegue", sender: indexPath!);
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let ll = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout;
        ll.itemSize = CGSize(width: self.view.bounds.width / 3 - 1, height: self.view.bounds.width / 3 - 1);
        ll.minimumInteritemSpacing = 1;
        ll.minimumLineSpacing = 3;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allimages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! CollectionViewCell
        cell.dataImage = allimages[indexPath.row];
        cell.tag = indexPath.row;
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected));
        
        cell.imageView?.isUserInteractionEnabled = true;
        cell.imageView?.addGestureRecognizer(singleTap);
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
