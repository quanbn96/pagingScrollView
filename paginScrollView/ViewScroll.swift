//
//  ViewScroll.swift
//  paginScrollView
//
//  Created by Quan on 7/5/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {
    
    var tap = UITapGestureRecognizer()

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    var photo = UIImageView()
    var pageImages : [String] = []
    var first = false
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["Image0", "Image1", "Image2", "Image3"]
        pageController.currentPage = 0
        pageController.numberOfPages = pageImages.count
        print(ScrollView.bounds.size)
        
        ScrollView.maximumZoomScale = 2
        ScrollView.minimumZoomScale = 0.5
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        if first == false {
            first = true
            let pageScrollViewSize = ScrollView.bounds.size
            ScrollView.contentSize = CGSizeMake(pageScrollViewSize.width * CGFloat(pageImages.count), 0)
            
            for (var i = 0; i < pageImages.count; i++) {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                imgView.frame = CGRectMake(CGFloat(i) * ScrollView.frame.size.width, 0, ScrollView.frame.size.width, ScrollView.frame.size.height)
                imgView.contentMode = .ScaleAspectFit
                ScrollView.addSubview(imgView)
                
                if i == 0 {
                    self.photo = imgView
                }
                
                
            }
            print(ScrollView.bounds.size)
        }

    }

    @IBAction func onChange(sender: AnyObject) {
        ScrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * ScrollView.frame.size.width, 0)
    }
    
    func onTap(tapGesture : UITapGestureRecognizer) {
        let point = tapGesture.locationInView(self.photo)
        zoomRectForScale(ScrollView.zoomScale * 2, center: point)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.photo
    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) {
        var zoomRect = CGRect()
        var scrollViewSize = self.ScrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        self.ScrollView.zoomToRect(zoomRect, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageController.currentPage = Int(ScrollView.contentOffset.x / ScrollView.bounds.size.width)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //pageController.currentPage = Int(ScrollView.contentOffset.x / ScrollView.bounds.size.width)
    }
    
}
