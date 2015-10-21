//
//  ViewController.swift
//  TapBarView
//
//  Created by 孔去愚 on 15/10/21.
//  Copyright © 2015年 孔去愚. All rights reserved.
//

import UIKit

class TapBarViewController: UIViewController, UIScrollViewDelegate
{
    var segmentedCotrol: UISegmentedControl!
    var scrollView: UIScrollView!
    var navbarView: UIView!
    
    var titleBackgroundView: UIView!
    var titleSelectedView: UIView!
    
    var titleView1: UILabel!
    var titleView2: UILabel!
    
    var contentView1: UITableView!
    var contentView2: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let wBounds = self.view.bounds.width
        let hBounds = self.view.bounds.height
        
        //set scrollView
        scrollView = UIScrollView()
        scrollView.frame = self.view.frame
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = true
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: wBounds*2, height: hBounds)
        
        //set navigationBarView
        navbarView = UIView()
        self.navigationController?.navigationBar.addSubview(navbarView)
        
        //set the backgroundView of titles
        let NavWith = self.navigationController?.navigationBar.frame.width
        let NavHeight = self.navigationController?.navigationBar.frame.height
        titleBackgroundView = UIView()
        titleBackgroundView.frame = CGRectMake(NavWith!*3/8, NavHeight!/4, NavWith!/4, NavHeight!/2)
        self.navbarView.addSubview(titleBackgroundView)
        self.navbarView.bringSubviewToFront(titleBackgroundView)
        
        //set the view to heighlight the selected title
        titleSelectedView = UIView()
        titleSelectedView.backgroundColor = UIColor.grayColor()
        titleSelectedView.frame = CGRect(x: 0, y: 0, width: titleBackgroundView.frame.width/2, height: titleBackgroundView.frame.height)
        titleBackgroundView.addSubview(titleSelectedView)
        
        //set the titleviews
        titleView1 = UILabel()
        titleView1.text = "test"
        titleView1.textColor = UIColor.blackColor()
        titleView1.textAlignment = NSTextAlignment.Center
        titleView1.frame = CGRect(x: 0, y: 0, width: titleBackgroundView.frame.width/2, height: titleBackgroundView.frame.height)
        titleView1.userInteractionEnabled = true
        titleBackgroundView.addSubview(titleView1)
        titleView1.userInteractionEnabled = true
        titleBackgroundView.bringSubviewToFront(titleView1)
        titleView1.userInteractionEnabled = true
        
        titleView2 = UILabel()
        titleView2.text = "test"
        titleView2.textColor = UIColor.blackColor()
        titleView2.textAlignment = NSTextAlignment.Center
        titleView2.frame = CGRect(x: titleBackgroundView.frame.width/2, y: 0, width: titleBackgroundView.frame.width/2, height: titleBackgroundView.frame.height)
        titleBackgroundView.addSubview(titleView2)
        titleView2.userInteractionEnabled = true
        titleBackgroundView.bringSubviewToFront(titleView1)
        titleView2.userInteractionEnabled = true
        
        //set the segementedControl which can recieve a tap gesture
        segmentedCotrol = UISegmentedControl(items: ["",""])
        segmentedCotrol.frame = titleBackgroundView.frame
        self.navigationController?.navigationBar.addSubview(segmentedCotrol)
        segmentedCotrol.momentary = true
        segmentedCotrol.tintColor = UIColor.clearColor()
        segmentedCotrol.addTarget(self, action: "changeTitle:", forControlEvents: UIControlEvents.ValueChanged)
        
        //set the different contents for titles
        let yPositionForTableView = self.navigationController?.navigationBar.frame.maxY
        contentView1 = UITableView()
        contentView1.frame = CGRect(x: 0, y: yPositionForTableView!, width: wBounds, height: hBounds)
        contentView1.backgroundColor = UIColor.purpleColor()
        self.scrollView.addSubview(contentView1)
        self.scrollView.bringSubviewToFront(contentView1)
        
        contentView2 = UITableView()
        contentView2.frame = CGRect(x: wBounds, y: yPositionForTableView!, width: wBounds, height: hBounds)
        contentView2.backgroundColor = UIColor.orangeColor()
        self.scrollView.addSubview(contentView2)
        self.scrollView.bringSubviewToFront(contentView2)
    }
    
    func changeTitle(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let wBounds = self.view.bounds.width
        switch index {
        case 0:
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1:
            self.scrollView.setContentOffset(CGPoint(x: wBounds, y: 0), animated: true)
        default:break
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        let hBounds = titleBackgroundView.frame.height
        let wBounds = titleBackgroundView.frame.width
        let titleSelectViewPosition = xOffset * wBounds / (2*self.view.bounds.width)
        
        titleSelectedView.frame = CGRectMake(titleSelectViewPosition, 0, wBounds/2, hBounds)
    }
}


