//
//  ViewController.swift
//  scrollview
//
//  Created by Sydney COHEN on 5/30/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var imageView : UIImageView?
    var image : UIImage?
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: "42")
        imageView = UIImageView(image: image)
        scrollview.addSubview(imageView!)
        scrollview.contentSize = (imageView?.frame.size)!
        scrollview.maximumZoomScale = 100
        scrollview.minimumZoomScale = 0.3
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

