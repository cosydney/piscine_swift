//
//  ViewController.swift
//  d03
//
//  Created by Sydney COHEN on 5/31/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    var lookupImage: UIImage?;
    var imageView: UIImageView?;
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setImageSize(width: size.width);
    }
    
    func setImageSize(width: CGFloat) {
        self.imageView!.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: self.imageView!.bounds.height / self.imageView!.bounds.width * width
        );
        scrollview.contentSize = imageView!.frame.size;
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return (imageView);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.imageView = UIImageView(image: self.lookupImage!);
        setImageSize(width: self.view.bounds.width);
        self.imageView!.contentMode = .scaleAspectFill;
        self.imageView!.clipsToBounds = true;
        scrollview.addSubview(self.imageView!);
        scrollview.isScrollEnabled = true;
        scrollview.maximumZoomScale = 100.0;
        scrollview.minimumZoomScale = 0.1;
        scrollview.delegate = self;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

