//
//  ViewController.swift
//  PullToRefresh
//
//  Created by FanYu on 30/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 手动刷新 与 载入app时刷新
    var pullToRefreshShape: CAShapeLayer!
    var loadingShape: CAShapeLayer!
    
    // 刷新指示器 content View
    let loadingIndicator = UIView()
    
    // 加载指示
    var isLoading: Bool!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading = true
        
        setupLoadingIndicator()
        
        isLoading = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: - Scroll Delegate
//
extension ViewController {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 偏移量
        let offset = scrollView.contentOffset.y + scrollView.contentInset.top
        
        // 下拉 并且 当前没有加载中
        if offset <= 0.0 && !self.isLoading {
            
            let startLoadingThreshold: CGFloat = 60
            let fractionDragged = -offset / startLoadingThreshold
            
            self.pullToRefreshShape.timeOffset = min(1.0, Double(fractionDragged))
            
            // 下拉到 thread 时开始刷新加载数据
            if fractionDragged >= 1.0 {
                self.startLoading()
            }
        }
    }
}


// MARK: - Setup 
//
extension ViewController {
    
    func setupLoadingIndicator() {
        
        // content view
        loadingIndicator.frame = CGRect(x: 0, y: -70, width: self.view.bounds.size.width, height: 70)
        loadingIndicator.backgroundColor = UIColor.orangeColor()
        self.collectionView.addSubview(loadingIndicator)
        
        // 实例化
        pullToRefreshShape = CAShapeLayer()
        loadingShape = CAShapeLayer()
        
        // 载入 Path  load|ing
        pullToRefreshShape.path = loadPath()
        loadingShape.path = ingPath()
        
        // 动画属性设置
        for shape in [pullToRefreshShape, loadingShape] {
            shape.fillColor = UIColor.clearColor().CGColor // 路径的填充色 未开始stroke时
            shape.strokeColor = UIColor.blackColor().CGColor // 画路径走过后的线颜色
            shape.lineCap = kCALineCapRound // 笔划终端 圆头
            shape.lineWidth = 5.0 //  线宽
            shape.position = CGPoint(x: 70, y: 0) // 划线的起始位置
            shape.strokeEnd = 0.0 // 笔划终点
            loadingIndicator.layer.addSublayer(shape)
        }
        
        // 手动控制下拉时的动画offset，所以要停止动画速度
        pullToRefreshShape.speed = 0
        
        // 添加动画
        pullToRefreshShape.addAnimation(pullDownAnimation(), forKey: "Pull Down to write")
    }
}


// MARK: - Animation
//
extension ViewController {
    
    // 手动刷新动画，由两个动画组成 划线 和 下移
    func pullDownAnimation() ->CAAnimationGroup {
        
        // Text is drawn by stroking the path from 0% to 100%
        let writeText = CABasicAnimation(keyPath: "strokeEnd")
        writeText.fromValue = 0
        writeText.toValue = 1
        
        // The layer is moved up so that the larger loading layer can fit above the cells
        let move = CABasicAnimation(keyPath: "position.y")
        move.byValue = -12
        move.toValue = 20
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1 // 与 timeoffset 相互配合 相当于总时长的百分比
        groupAnimation.animations = [writeText, move]
        
        return groupAnimation
    }
    
    // 自动刷新加载动画
    func loadingAnimation() ->CABasicAnimation{
        
        let write2 = CABasicAnimation(keyPath: "strokeEnd")
        write2.fromValue = 0
        write2.toValue = 1
        write2.fillMode = kCAFillModeBoth
        write2.removedOnCompletion = false
        write2.duration = 1
        
        return write2
    }
    
    // 开始自动加载
    func startLoading() {
        self.isLoading = true
        
        self.loadingShape.addAnimation(self.loadingAnimation(), forKey: "Write the word")
        
        // 设置顶部 inset 使得下拉后 开始加载时 view 可以在顶部保留一段时间
        let contentInset = self.collectionView.contentInset.top
        self.collectionView.contentInset = UIEdgeInsets(top: contentInset + CGRectGetHeight(self.loadingIndicator.frame), left: 0, bottom: 0, right: 0)
        //self.collectionView.scrollEnabled = false
        
        // 一段时间后停止保留，恢复原位置
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(3) * Int64(NSEC_PER_SEC))
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                // 恢复 inset.top 为 原来数值
                self.collectionView.contentInset = UIEdgeInsets(top: contentInset, left: 0, bottom: 0, right: 0)
                
                }, completion: { (Bool) -> Void in
                    
                    self.loadingShape.removeAllAnimations()
                    self.loadingIndicator.alpha = 1
                    self.collectionView.scrollEnabled = true
                    self.pullToRefreshShape.timeOffset = 0.0 // back to start
                    
                    self.isLoading = false
            })
        }
    }
}






// MARK: - Path Data
// 
extension ViewController {
    func loadPath() ->CGPathRef {
        
        let path: CGMutablePathRef = CGPathCreateMutable()
        
        CGPathMoveToPoint(path,     nil, 7.50878897, 25.2871097)
        CGPathAddCurveToPoint(path, nil, 7.50878897, 25.2871097,  21.7333976, 26.7812495, 29.6894527, 20.225586)
        CGPathAddCurveToPoint(path, nil, 37.6455074, 13.6699219,  39.367189,  3.85742195, 31.9697262, 1.25976564)
        CGPathAddCurveToPoint(path, nil, 24.5722639, -1.33789083, 21.99707,   10.9072268, 21.99707,   22.2255862)
        CGPathAddCurveToPoint(path, nil, 21.9970685, 33.5439456,  15.9355469, 45.8212894, 8.99707031, 47.7294922)
        CGPathAddCurveToPoint(path, nil, 2.05859375, 49.637695,   3.67187498, 44.0332034, 7.50878897, 44.0332034)
        CGPathAddCurveToPoint(path, nil, 11.3457029, 44.0332034,  16.9277345, 44.234375,  25.5234372, 47.7294925)
        CGPathAddCurveToPoint(path, nil, 30.55635,   49.7759358,  37.9023439, 49.5410159, 44.1259762, 35.9140628)
        CGPathAddCurveToPoint(path, nil, 50.349609,  22.2871097,  55.3105465, 25.2871099, 60.7128903, 25.2871097)
        CGPathAddCurveToPoint(path, nil, 66.481445,  25.2871097,  56.192383,  22.6435549, 50.8017578, 26.6455078)
        CGPathAddCurveToPoint(path, nil, 45.4111325, 30.6474606,  43.4619148, 37.8193362, 46.0097656, 43.7333984)
        CGPathAddCurveToPoint(path, nil, 48.5576169, 49.6474606,  57.0488304, 50.0810555, 61.8876968, 43.0097659)
        CGPathAddCurveToPoint(path, nil, 66.7265637, 35.9384765,  65.6816424, 31.5634772, 64.4834,    27.8232425)
        CGPathAddCurveToPoint(path, nil, 63.2851574, 24.0830078,  59.8876972, 27.8076178, 59.8876968, 31.4882815)
        CGPathAddCurveToPoint(path, nil, 59.8876965, 35.1689453,  69.1025406, 37.2509768, 74.9531265, 32.7333987)
        CGPathAddCurveToPoint(path, nil, 80.8037132, 28.2158207,  80.1298793, 27.0527347, 84.4970703, 25.3574219)
        CGPathAddCurveToPoint(path, nil, 88.8642613, 23.6621091,  93.7460906, 25.37793,   96.1650391, 28.8349609)
        CGPathAddCurveToPoint(path, nil, 96.1650391, 28.8349609,  91.6679688, 24.28711,   88.085941,  24.2871097)
        CGPathAddCurveToPoint(path, nil, 84.5039132, 24.2871093,  74.9824181, 33.0332029, 78.5166016, 43.3417969)
        CGPathAddCurveToPoint(path, nil, 82.0507847, 53.6503909,  92.167965,  42.5078128, 95.0117188, 38.9140625)
        CGPathAddCurveToPoint(path, nil, 97.8554722, 35.3203122,  100.327144, 27.9042972, 100.327148, 23.3740234)
        CGPathAddCurveToPoint(path, nil, 100.327152, 18.8437497,  96.499996,  26.5527347, 96.5,       32.7333984)
        CGPathAddCurveToPoint(path, nil, 96.5000035, 38.9140622,  92.6337871, 53.1660163, 101.700195, 46.0400391)
        CGPathAddCurveToPoint(path, nil, 110.766605, 38.9140622,  112.455075, 29.5751958, 118.345703, 26.9746094)
        CGPathAddCurveToPoint(path, nil, 124.236332, 24.3740231,  129.221685, 27.5800787, 131.216798, 30.1386722)
        CGPathAddCurveToPoint(path, nil, 131.216798, 30.1386722,  125.394529, 25.9746094, 121.82422,  25.9746097)
        CGPathAddCurveToPoint(path, nil, 118.253911, 25.9746099,  110.588871, 32.4130862, 112.661136, 41.7500003)
        CGPathAddCurveToPoint(path, nil, 114.733402, 51.0869143,  119.810543, 48.9121097, 125.347656, 43.0097656)
        CGPathAddCurveToPoint(path, nil, 130.884769, 37.1074216,  137.702153, 21.0126953, 139.335938, 12.4980469)
        CGPathAddCurveToPoint(path, nil, 140.969722, 3.98339847,  140.637699,-2.27636688, 136.845703, 7.984375)
        CGPathAddCurveToPoint(path, nil, 134.586089, 14.0986513,  131.676762, 31.5527347, 129.884769, 38.9140628)
        CGPathAddCurveToPoint(path, nil, 128.092777, 46.2753909,  130.551236, 50.2217745, 135.211914, 46.2753906)
        CGPathAddCurveToPoint(path, nil, 146.745113, 36.5097659,  142.116211, 40.75,      142.116211, 40.75)

        var transform: CGAffineTransform = CGAffineTransformMakeScale(0.7, 0.7)
        
        return CGPathCreateCopyByTransformingPath(path, &transform)!
    }
    
    func ingPath() ->CGPathRef {
        
        let path: CGMutablePathRef = CGPathCreateMutable()
        
        // ing minus dot
        CGPathMoveToPoint(path,     nil, 139.569336, 42.9423837)
        CGPathAddCurveToPoint(path, nil, 139.569336, 42.9423837, 149.977539, 32.9609375, 151.100586, 27.9072266)
        CGPathAddCurveToPoint(path, nil, 152.223633, 22.8535156, 149.907226, 21.5703124, 148.701172, 26.5419921)
        CGPathAddCurveToPoint(path, nil, 147.495117, 31.5136718, 142.760742, 50.8046884, 149.701172, 48.2763681)
        CGPathAddCurveToPoint(path, nil, 156.641602, 45.7480478, 166.053711, 33.5791017, 167.838867, 29.5136719)
        CGPathAddCurveToPoint(path, nil, 169.624023, 25.4482421, 169.426758, 20.716797,  167.455078, 26.1152344)
        CGPathAddCurveToPoint(path, nil, 165.483398, 31.5136718, 165.618164, 42.9423835, 163.97168,  48.2763678)
        CGPathAddCurveToPoint(path, nil, 163.97168,  48.2763678, 163.897461, 41.4570313, 168.141602, 35.9375)
        CGPathAddCurveToPoint(path, nil, 172.385742, 30.4179687, 179.773438, 21.9091796, 183.285645, 26.6875)
        CGPathAddCurveToPoint(path, nil, 186.797851, 31.4658204, 177.178223, 48.2763684, 184.285645, 48.2763678)
        CGPathAddCurveToPoint(path, nil, 191.393066, 48.2763678, 196.006836, 38.8701172, 198.850586, 34.0449218)
        CGPathAddCurveToPoint(path, nil, 201.694336, 29.2197264, 207.908203, 19.020508,  216.71875,  28.4179687)
        CGPathAddCurveToPoint(path, nil, 216.71875,  28.4179687, 211.086914, 23.5478516, 206.945312, 24.6738281)
        CGPathAddCurveToPoint(path, nil, 202.803711, 25.7998046, 194.8125,   40.1455079, 201.611328, 47.2763672)
        CGPathAddCurveToPoint(path, nil, 208.410156, 54.4072265, 220.274414, 30.9111327, 221.274414, 26.6874999)
        CGPathAddCurveToPoint(path, nil, 222.274414, 22.4638672, 220.005859, 20.3759766, 218.523438, 28.5419922)
        CGPathAddCurveToPoint(path, nil, 217.041016, 36.7080077, 216.630859, 64.7705084, 209.121094, 71.012696)
        CGPathAddCurveToPoint(path, nil, 201.611328, 77.2548835, 197.109375, 65.0654303, 202.780273, 60.9287116)
        CGPathAddCurveToPoint(path, nil, 208.451172, 56.7919928, 224.84668,  51.0244147, 228.638672, 38.6855466)
        
        // dot
        CGPathMoveToPoint(path,     nil, 153.736328, 14.953125)
        CGPathAddCurveToPoint(path, nil, 153.736328, 14.953125,  157.674805, 12.8178626, 155.736328, 10.2929688)
        CGPathAddCurveToPoint(path, nil, 153.797852, 7.76807493, 151.408203, 12.2865614, 152.606445, 14.9531252)
        
        var transform: CGAffineTransform = CGAffineTransformMakeScale(0.7, 0.7)
        
        return CGPathCreateCopyByTransformingPath(path, &transform)!
    }
}



// MARK: - CollectionView DataSource
//
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }
}


// MARK: - CollectionView Delegate FlowLayout
//
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemWidth = (view.bounds.size.width - 2) / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
}