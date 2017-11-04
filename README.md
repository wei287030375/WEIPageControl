# WEIPageControl
SWIFT版自定义PageControl，椭圆，空心圆，图片点

刚开始做swift项目，可用资源太少了，参考一个object-C的PageControl自己做了一个swift版的，
参考OC资源链接：https://github.com/hackxhj/EllipsePageControl， 非常感谢原作者
本项目在原OC的功能基础上进行的改进，增加了自定义点的宽度，点的layer，不是当前点的图片等功能
基本能满足大部分的需求，写的很简单，大家一看就懂，欢迎大家使用
由于水平有限，项目中有改进之处忘各位大神给与指点，以求不断完善
本人联系方式：wei287030375@sina.com

以下是部分代码：

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



在ViewController中使用

//宽一点的当前点  
       pageControl2 = WEIPageControl()//初始化PageControl
        pageControl2.frame = CGRect.init(x: left, y: scrollView2.frame.maxY, width: width, height: 20)
        pageControl2.numberOfPages = pageCount//总页数
        pageControl2.currentWidthMultiple = 4//当前点的宽度为其他点的4倍
        pageControl2.pointSize = CGSize.init(width: 9, height: 9)//点的size
        pageControl2.clickPoint { (index) in//圆点的点击事件
            self.scrollView2.setContentOffset(CGPoint.init(x: width * CGFloat(index!), y: 0), animated: true)
        }

代码就是这么简单，欢迎大家使用，

