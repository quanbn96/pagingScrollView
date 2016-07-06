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
    
    var photo: [UIImageView] = []
    var pageImages : [String] = []
    var frontScrollView: [UIScrollView] = []
    var first = false
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["Image0", "Image1", "Image2", "Image3"]
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        print(ScrollView.bounds.size)
        
       
    }
    
    override func viewDidLayoutSubviews() {
        
        if first == false {
            first = true
            let pageScrollViewSize = ScrollView.bounds.size
            ScrollView.contentSize = CGSizeMake(pageScrollViewSize.width * CGFloat(pageImages.count), pageScrollViewSize.height)
            ScrollView.contentOffset = CGPointMake(CGFloat(currentPage) * pageScrollViewSize.width, 0)
            
            // creat frontScrollView + imgView and add imgView for frontScrollView
            for (var i = 0; i < pageImages.count; i++) {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                imgView.frame = CGRectMake(0, 0, ScrollView.frame.size.width, ScrollView.frame.size.height)
                imgView.contentMode = .ScaleAspectFit
                self.addTapAndDoubleTapForImgView(imgView)
                self.photo.append(imgView)
                
                let fontScrollView = UIScrollView(frame: CGRect(x: CGFloat(i) * ScrollView.frame.size.width, y: 0, width: ScrollView.frame.size.width, height: ScrollView.frame.size.height))
                
                fontScrollView.maximumZoomScale = 2
                fontScrollView.minimumZoomScale = 0.5
                fontScrollView.delegate = self
                
                self.frontScrollView.append(fontScrollView)
                
                ScrollView.addSubview(fontScrollView)
                fontScrollView.addSubview(imgView)
            }
        }
        self.addButtonForView(self.view)

    }
    
    
    func backAction(sender : UIButton) {
        if(pageController.currentPage != 0) {
            UIView.animateWithDuration(0.2, animations: {
                self.pageController.currentPage = self.pageController.currentPage - 1
                self.ScrollView.contentOffset = CGPointMake(CGFloat(self.pageController.currentPage) * self.ScrollView.frame.size.width, 0)
            })
            
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    func nextAction(sender : UIButton) {
        if(pageController.currentPage != pageImages.count) {
            UIView.animateWithDuration(0.2, animations: {
                self.pageController.currentPage = self.pageController.currentPage + 1
                
                self.ScrollView.contentOffset = CGPointMake(CGFloat(self.pageController.currentPage) * self.ScrollView.frame.size.width, 0)
            })
            
        }
    }
    
    func addTapAndDoubleTapForImgView(imgView : UIImageView) {
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapImg(_:)))
        tap.numberOfTapsRequired = 1
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapImg(_:)))
        doubleTap.numberOfTapsRequired = 2
        
        tap.requireGestureRecognizerToFail(doubleTap)
        
        imgView.addGestureRecognizer(tap)
        imgView.addGestureRecognizer(doubleTap)
    }
    
    func addButtonForView(view : UIView) {
        let backButton = UIButton(frame: CGRect(x: 0, y: ScrollView.frame.size.height / 2.0, width: 40, height: 40))
        backButton.setBackgroundImage(UIImage(named: "back.png"), forState: .Normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), forControlEvents: .TouchUpInside)
        
        let nextButton = UIButton(frame: CGRect(x: ScrollView.frame.size.width, y: ScrollView.frame.size.height / 2.0, width: 40, height: 40))
        nextButton.setBackgroundImage(UIImage(named: "next.png"), forState: .Normal)
        nextButton.addTarget(self, action: #selector(self.nextAction(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(nextButton)
        view.addSubview(backButton)
        
    }

    @IBAction func onChange(sender: AnyObject) {
        ScrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * ScrollView.frame.size.width, 0)
    }
    
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.photo[self.pageController.currentPage]
    }
    
    func tapImg(gesture : UITapGestureRecognizer) {
        let point = gesture.locationInView(photo[self.pageController.currentPage])
        zoomRectForScale(self.frontScrollView[self.pageController.currentPage].zoomScale * 1.5, center: point)
    }
    
    func doubleTapImg(gesture : UITapGestureRecognizer) {
        let point = gesture.locationInView(photo[self.pageController.currentPage])
        zoomRectForScale(self.frontScrollView[self.pageController.currentPage].zoomScale * 0.5, center: point)
    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) {
        var zoomRect = CGRect()
        var scrollViewSize = self.ScrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        self.frontScrollView[pageController.currentPage].zoomToRect(zoomRect, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageController.currentPage = Int(ScrollView.contentOffset.x / ScrollView.bounds.size.width)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //pageController.currentPage = Int(ScrollView.contentOffset.x / ScrollView.bounds.size.width)
    }
    
}
