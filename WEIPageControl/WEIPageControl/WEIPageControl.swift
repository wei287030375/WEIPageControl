//
//  WEIPageControl.swift
//  WEIPageControl
//
//  Created by IOB on 2017/11/4.
//  Copyright © 2017年 weican. All rights reserved.
//  花了一天时间完成了本功能，欢迎大家使用
//  另由于水平有限，其中必有很多改进之处，欢迎各位大神给与意见不断完善
//  联系方式：wei287030375@sina.com

import UIKit

class WEIPageControl: UIControl {


    var localNumberOfPages = NSInteger()//分页数量
    var localCurrentPage = NSInteger()//当前点所在下标
    var localPointSize = CGSize()//点的大小
    var localPointSpace = CGFloat()//点之间的间距
    var localOtherColor = UIColor()//未选中点的颜色
    var localCurrentColor = UIColor()//当前点的颜色
    var localOtherImage: UIImage?//未选中点的图片
    var localCurrentImage: UIImage?//当前点的图片
    var localCurrentWidthMultiple = CGFloat()//当前选中点宽度与未选中点的宽度的倍数
    var localOtherBorderColor: UIColor?//未选中点的layerColor
    var localOtherBorderWidth: CGFloat?//未选中点的layer宽度
    var localCurrentBorderColor: UIColor?//未选中点的layerColor
    var localCurrentBorderWidth: CGFloat?//未选中点的layer宽度
    var clickIndex: ((_ result: NSInteger?) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        self.backgroundColor = UIColor.clear
        localNumberOfPages = 0//必须传入总页数
        localCurrentPage = 0//默认当前页数为第一页
        localPointSize = CGSize.init(width: 6, height: 6)//默认点的宽高分别为6
        localPointSpace = 8//默认点的间距为8
        localOtherColor = UIColor.init(white: 1, alpha: 0.5)//默认未选中点的颜色为白色，透明度50%
        localCurrentColor = UIColor.white//默认选中点的颜色为白色
        localCurrentWidthMultiple = 1//当前选中点宽度与未选中点的宽度的倍数，默认为1倍
        creatPointView()//创建view
    }

    var numberOfPages: NSInteger {
        set {
            if localNumberOfPages == newValue {
                return
            }
            localNumberOfPages = newValue
            creatPointView()
        }
        get {
            return self.localNumberOfPages
        }
    }

    var currentPage: NSInteger {
        set {
            if localCurrentPage == newValue {
                return
            }
            exchangeCurrentView(oldSelectedIndex: localCurrentPage, newSelectedIndex: newValue)
            localCurrentPage = newValue
        }
        get {
            return self.localCurrentPage
        }
    }

    var pointSize: CGSize {
        set {
            if localPointSize != newValue {
                localPointSize = newValue
                creatPointView()
            }
        }
        get {
            return self.localPointSize
        }
    }

    var pointSpace: CGFloat {
        set {
            if localPointSpace != newValue{
                localPointSpace = newValue
                creatPointView()
            }
        }
        get {
            return self.localPointSpace
        }
    }

    var otherColor: UIColor {
        set {
            if localOtherColor != newValue {
                localOtherColor = newValue
                creatPointView()
            }
        }
        get {
            return self.localOtherColor
        }
    }

    var currentColor: UIColor {
        set {
            if localCurrentColor != newValue {
                localCurrentColor = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentColor
        }
    }

    var otherImage: UIImage {
        set {
            if localOtherImage != newValue {
                localOtherImage = newValue
                creatPointView()
            }
        }
        get {
            return self.localOtherImage!
        }
    }

    var currentImage: UIImage {
        set{
            if localCurrentImage != newValue {
                localCurrentImage = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentImage!
        }
    }

    var currentWidthMultiple: CGFloat {
        set {
            if localCurrentWidthMultiple != newValue {
                localCurrentWidthMultiple = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentWidthMultiple
        }
    }

    var otherBorderColor: UIColor {
        set {
            localOtherBorderColor = newValue
            creatPointView()
        }
        get {
            return self.localOtherBorderColor!
        }
    }

    var otherBorderWidth: CGFloat {
        set {
            localOtherBorderWidth = newValue
            creatPointView()
        }
        get {
            return self.localOtherBorderWidth!
        }
    }

    var currentBorderColor: UIColor {
        set {
            localCurrentBorderColor = newValue
            creatPointView()
        }
        get {
            return self.localCurrentBorderColor!
        }
    }

    var currentBorderWidth: CGFloat {
        set {
            localCurrentBorderWidth = newValue
            creatPointView()
        }
        get {
            return self.localCurrentBorderWidth!
        }
    }

    func creatPointView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }

        if localNumberOfPages <= 0 {//必须传入总页数
            return
        }

        var startX: CGFloat = 0
        var startY:CGFloat = 0
        let mainWidth = CGFloat(localNumberOfPages) * (localPointSize.width + localPointSpace)

        if self.frame.size.width > mainWidth {
            startX = (self.frame.size.width - mainWidth) / 2
        }

        if self.frame.size.height > localPointSize.height {
            startY = (self.frame.size.height - localPointSize.height) / 2
        }

        //创建点
        for index in 0 ..< numberOfPages {
            if index == localCurrentPage {//是当前点
                let currentPointView = UIView.init()
                let currentPointViewWidth = localPointSize.width * localCurrentWidthMultiple
                currentPointView.frame = CGRect.init(x: startX, y: startY, width: currentPointViewWidth, height: localPointSize.height)
                currentPointView.backgroundColor = localCurrentColor
                currentPointView.tag = index + 1000
                currentPointView.layer.cornerRadius = localPointSize.height / 2
                currentPointView.layer.masksToBounds = true
                currentPointView.layer.borderColor = localCurrentBorderColor != nil ? localCurrentBorderColor?.cgColor : localCurrentColor.cgColor
                currentPointView.layer.borderWidth = localCurrentBorderWidth != nil ? localCurrentBorderWidth! : 0
                currentPointView.isUserInteractionEnabled = true
                self.addSubview(currentPointView)
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(tapGesture:)))//添加小圆点点击手势
                currentPointView.addGestureRecognizer(tapGesture)
                startX = currentPointView.frame.maxX + localPointSpace

                if localCurrentImage != nil {
                    currentPointView.backgroundColor = UIColor.clear
                    let localCurrentImageView = UIImageView.init()
                    localCurrentImageView.tag = index + 2000
                    localCurrentImageView.frame = currentPointView.bounds
                    localCurrentImageView.image = localCurrentImage
                    currentPointView.addSubview(localCurrentImageView)
                }
            } else {//其他点
                let otherPointView = UIView.init()
                otherPointView.frame = CGRect.init(x: startX, y: startY, width: localPointSize.width, height: localPointSize.height)
                otherPointView.backgroundColor = localOtherColor
                otherPointView.tag = index + 1000
                otherPointView.layer.cornerRadius = localPointSize.height / 2;
                otherPointView.layer.borderColor = localOtherBorderColor != nil ? localOtherBorderColor?.cgColor : localOtherColor.cgColor
                otherPointView.layer.borderWidth = localOtherBorderWidth != nil ? localOtherBorderWidth! : 0
                otherPointView.layer.masksToBounds = true
                otherPointView.isUserInteractionEnabled = true
                self.addSubview(otherPointView)
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(tapGesture:)))
                otherPointView.addGestureRecognizer(tapGesture)
                startX = otherPointView.frame.maxX + localPointSpace

                if localOtherImage != nil {
                    otherPointView.backgroundColor = UIColor.clear
                    let localOtherImageView = UIImageView.init()
                    localOtherImageView.tag = index + 2000
                    localOtherImageView.frame = otherPointView.bounds
                    localOtherImageView.image = localOtherImage
                    otherPointView.addSubview(localOtherImageView)
                }
            }
        }
    }

    func exchangeCurrentView(oldSelectedIndex: NSInteger, newSelectedIndex: NSInteger) {//切换当前点和其他点
        let oldPointView = self.viewWithTag(1000 + oldSelectedIndex)
        let newPointView = self.viewWithTag(1000 + newSelectedIndex)

        oldPointView?.layer.borderColor = localOtherBorderColor != nil ? localOtherBorderColor?.cgColor : localOtherColor.cgColor
        oldPointView?.layer.borderWidth = localOtherBorderWidth != nil ? localOtherBorderWidth! : 0

        newPointView?.layer.borderColor = localCurrentBorderColor != nil ? localCurrentBorderColor?.cgColor : localCurrentColor.cgColor
        newPointView?.layer.borderWidth = localCurrentBorderWidth != nil ? localCurrentBorderWidth! : 0

        oldPointView?.backgroundColor = localOtherColor
        newPointView?.backgroundColor = localCurrentColor

        if localCurrentWidthMultiple != 1 {//如果当前选中点的宽度与未选中的点宽度不一样，则要改变选中前后两点的frame
            var oldPointFrame = oldPointView?.frame
            if newSelectedIndex < oldSelectedIndex {
                oldPointFrame?.origin.x += localPointSize.width * (localCurrentWidthMultiple - 1)
            }
            oldPointFrame?.size.width = localPointSize.width
            oldPointView?.frame = oldPointFrame!

            var newPointFrame = newPointView?.frame
            if newSelectedIndex > oldSelectedIndex {
                newPointFrame?.origin.x -= localPointSize.width * (localCurrentWidthMultiple - 1)
            }
            newPointFrame?.size.width = localPointSize.width * localCurrentWidthMultiple
            newPointView?.frame = newPointFrame!
        }

        if localCurrentImage != nil {//切换选中图片和未选中图片
            let view = oldPointView?.viewWithTag(oldSelectedIndex + 2000)

            if view != nil {
                let oldlocalCurrentImageView = view as! UIImageView

                oldlocalCurrentImageView.frame = CGRect.init(x: 0, y: 0, width: localPointSize.width, height: localPointSize.height)
                oldlocalCurrentImageView.image = localOtherImage
            }
        }

        if localOtherImage != nil {//切换选中图片和未选中图片
            let view = newPointView?.viewWithTag(newSelectedIndex + 2000)
            if view != nil {
                let oldlocalOtherImageView = view as! UIImageView
                let width = localPointSize.width * localCurrentWidthMultiple

                oldlocalOtherImageView.frame = CGRect.init(x: 0, y: 0, width: width, height: localPointSize.height)
                oldlocalOtherImageView.image = localCurrentImage

            }
        }

        if newSelectedIndex - oldSelectedIndex > 1 {//点击圆点，中间有跳过的点
            for index in oldSelectedIndex + 1 ..< newSelectedIndex {
                let view = self.viewWithTag(1000 + index)
                var frame = view?.frame
                frame?.origin.x -= localPointSize.width * (localCurrentWidthMultiple - 1)
                frame?.size.width = localPointSize.width
                view?.frame = frame!
            }
        }

        if newSelectedIndex - oldSelectedIndex < -1 {//点击圆点，中间有跳过的点
            for index in newSelectedIndex + 1 ..< oldSelectedIndex {
                let view = self.viewWithTag(1000 + index)
                var frame = view?.frame
                frame?.origin.x += localPointSize.width * (localCurrentWidthMultiple - 1)
                frame?.size.width = localPointSize.width
                view?.frame = frame!
            }
        }
    }

    @objc func clickAction(tapGesture: UITapGestureRecognizer) {//点击小圆点
        let index = (tapGesture.view?.tag)! - 1000
        self.clickIndex?(index)

    }

    func clickPoint(index: @escaping (_ result: NSInteger?) -> ()) {
        self.clickIndex = index;
    }

}
