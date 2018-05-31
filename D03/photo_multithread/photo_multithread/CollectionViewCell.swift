//
//  CollectionViewCell.swift
//  photo_multithread
//
//  Created by Sydney COHEN on 5/31/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataImage: (String)? {
        didSet {
            let queue = DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass);
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
            activityIndicator.hidesWhenStopped = true;
            activityIndicator.startAnimating();
            queue.async{
                if let url = URL(string: self.dataImage!) {
                    do {
                        let data = try Data(contentsOf: url);
                        let image: UIImage = UIImage(data: data)!;
                        
                        DispatchQueue.main.async {
                            self.imageView?.image = image;
                            self.imageView?.contentMode = .scaleAspectFill;
                            self.imageView?.clipsToBounds = true;
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.imageView?.backgroundColor = UIColor.lightGray;
                            if (self.window?.rootViewController?.presentedViewController == nil) {
                                let alert = UIAlertController(
                                    title: "Error",
                                    message: "Cannot access to \(self.dataImage!)",
                                    preferredStyle: UIAlertControllerStyle.alert
                                );
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                self.window?.rootViewController?.present(alert, animated: true, completion: nil);
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    if (numberOfImagesLoaded >= DataImages.images.count) {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                    }
                    self.activityIndicator.stopAnimating();
                }
                numberOfImagesLoaded += 1;
            }
        }
    }
    
}

