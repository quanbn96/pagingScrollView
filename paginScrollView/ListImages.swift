//
//  ListImages.swift
//  paginScrollView
//
//  Created by Quan on 7/5/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class ListImages: UIViewController {

    @IBAction func onTouch(sender: AnyObject) {
        switch sender.tag {
        case 101:
            self.pushView(0)
        case 102:
            self.pushView(1)
        case 103:
            self.pushView(2)
        case 104:
            self.pushView(3)
        default:
            break
        }
    }
    
    func pushView(index : Int) {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewScroll") as? ViewScroll
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

}
