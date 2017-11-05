//
//  ViewController.swift
//  WEIPageControl
//
//  Created by IOB on 2017/11/4.
//  Copyright © 2017年 weican. All rights reserved.
//
//  欢迎各位大神给与意见不断完善。联系方式：wei287030375@sina.com


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var pageControl1 = WEIPageControl()
    var pageControl2 = WEIPageControl()
    var pageControl3 = WEIPageControl()
    var pageControl4 = WEIPageControl()

    var scrollView1 = UIScrollView()
    var scrollView2 = UIScrollView()
    var scrollView3 = UIScrollView()
    var scrollView4 = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black

        let width: CGFloat = UIScreen.main.bounds.size.width * 0.7
        let height: CGFloat = 100
        let left: CGFloat = 50
        let pageCount = 5



        //==========================================================================================
        //空心圆
        scrollView1.frame = CGRect.init(x: left, y: 70, width: width, height: height)
        scrollView1.delegate = self
        scrollView1.tag = 1
        scrollView1.isPagingEnabled = true
        scrollView1.contentSize = CGSize.init(width: width * CGFloat(pageCount), height: 0)
        for index in 0 ..< pageCount {
            let imageView = UIImageView.init()
            imageView.frame = CGRect.init(x: CGFloat(index) * width, y: 0, width: width, height: height)
            imageView.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255) / CGFloat(255), green: CGFloat(arc4random()%255) / CGFloat(255), blue: CGFloat(arc4random()%255) / CGFloat(255), alpha: 1)
            scrollView1.addSubview(imageView)
        }

        pageControl1 = WEIPageControl()
        pageControl1.frame = CGRect.init(x: left, y: scrollView1.frame.maxY, width: width, height: 20)
        pageControl1.numberOfPages = pageCount
        pageControl1.pointSize = CGSize.init(width: 12, height: 12)
        pageControl1.otherColor = UIColor.black
        pageControl1.otherBorderWidth = 1
        pageControl1.otherBorderColor = UIColor.white
        pageControl1.currentColor = UIColor.orange

        pageControl1.clickPoint { (index) in
            self.scrollView1.setContentOffset(CGPoint.init(x: width * CGFloat(index!), y: 0), animated: true)

        }

        self.view.addSubview(scrollView1)
        self.view.addSubview(pageControl1)

        //==========================================================================================
        //宽一点的当前点
        scrollView2.frame = CGRect.init(x: left, y: pageControl1.frame.maxY + 30, width: width, height: height)
        scrollView2.delegate = self
        scrollView2.tag = 2
        scrollView2.isPagingEnabled = true
        scrollView2.contentSize = CGSize.init(width: width * CGFloat(pageCount), height: 0)
        for index in 0 ..< pageCount {
            let imageView = UIImageView.init()
            imageView.frame = CGRect.init(x: CGFloat(index) * width, y: 0, width: width, height: height)
            imageView.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255) / CGFloat(255), green: CGFloat(arc4random()%255) / CGFloat(255), blue: CGFloat(arc4random()%255) / CGFloat(255), alpha: 1)
            scrollView2.addSubview(imageView)
        }
        pageControl2 = WEIPageControl()//初始化PageControl
        pageControl2.frame = CGRect.init(x: left, y: scrollView2.frame.maxY, width: width, height: 20)
        pageControl2.numberOfPages = pageCount//总页数
        pageControl2.currentWidthMultiple = 4//当前点的宽度为其他点的4倍
        pageControl2.pointSize = CGSize.init(width: 9, height: 9)//点的size
        pageControl2.clickPoint { (index) in//圆点的点击事件
            self.scrollView2.setContentOffset(CGPoint.init(x: width * CGFloat(index!), y: 0), animated: true)
        }
        self.view.addSubview(scrollView2)
        self.view.addSubview(pageControl2)


        //==========================================================================================
        //宽一点的方点
        scrollView3.frame = CGRect.init(x: left, y: pageControl2.frame.maxY + 30, width: width, height: height)
        scrollView3.delegate = self
        scrollView3.tag = 3
        scrollView3.isPagingEnabled = true
        scrollView3.contentSize = CGSize.init(width: width * CGFloat(pageCount), height: 0)
        for index in 0 ..< pageCount {
            let imageView = UIImageView.init()
            imageView.frame = CGRect.init(x: CGFloat(index) * width, y: 0, width: width, height: height)
            imageView.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255) / CGFloat(255), green: CGFloat(arc4random()%255) / CGFloat(255), blue: CGFloat(arc4random()%255) / CGFloat(255), alpha: 1)
            scrollView3.addSubview(imageView)
        }
        pageControl3 = WEIPageControl()//初始化PageControl
        pageControl3.frame = CGRect.init(x: left, y: scrollView3.frame.maxY, width: width, height: 20)
        pageControl3.numberOfPages = pageCount//总页数
        pageControl3.isSquare = true//设置为方型点
        pageControl3.currentWidthMultiple = 2.5//当前点的宽度为其他点的3倍
        pageControl3.currentColor = UIColor.red
        pageControl3.otherColor = UIColor.blue
        pageControl3.pointSize = CGSize.init(width: 14, height: 6)//方点的size
        pageControl3.clickPoint { (index) in//方点的点击事件
            self.scrollView3.setContentOffset(CGPoint.init(x: width * CGFloat(index!), y: 0), animated: true)
        }
        self.view.addSubview(scrollView3)
        self.view.addSubview(pageControl3)

        //==========================================================================================
        //圆点图片
        scrollView4.frame = CGRect.init(x: left, y: pageControl3.frame.maxY + 30, width: width, height: height)
        scrollView4.delegate = self
        scrollView4.tag = 4
        scrollView4.isPagingEnabled = true
        scrollView4.contentSize = CGSize.init(width: width * CGFloat(pageCount), height: 0)
        for index in 0 ..< pageCount {
            let imageView = UIImageView.init()
            imageView.frame = CGRect.init(x: CGFloat(index) * width, y: 0, width: width, height: height)
            imageView.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255) / CGFloat(255), green: CGFloat(arc4random()%255) / CGFloat(255), blue: CGFloat(arc4random()%255) / CGFloat(255), alpha: 1)
            scrollView4.addSubview(imageView)
        }
        pageControl4 = WEIPageControl()
        pageControl4.frame = CGRect.init(x: left, y: scrollView4.frame.maxY, width: width, height: 40)
        pageControl4.numberOfPages = pageCount
        pageControl4.currentImage = UIImage.init(named: "Ktv_ic_share_weixin")!
        pageControl4.otherImage = UIImage.init(named: "Ktv_ic_share_qq")!
        pageControl4.pointSize = CGSize.init(width: 25, height: 25)
        pageControl4.clickPoint { (index) in
            self.scrollView4.setContentOffset(CGPoint.init(x: width * CGFloat(index!), y: 0), animated: true)

        }

        self.view.addSubview(scrollView4)
        self.view.addSubview(pageControl4)



    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        let showIndex = lroundf(Float(index))

        switch scrollView.tag {
        case 1:

            pageControl1.currentPage = showIndex
            break
        case 2:

            pageControl2.currentPage = showIndex
            break
        case 3:
            pageControl3.currentPage = showIndex
            break
        case 4:
            pageControl4.currentPage = showIndex
            break
        default:
            print("wu...")
        }



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

