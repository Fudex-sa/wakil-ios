//
//  CustomTabBarView.swift
//  Superfan
//
//  Created by ADAM on 23/01/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

typealias OnClickTabBarItem = ((Int) -> Void)
class CustomTabBarView : UIView {
    @IBOutlet weak var moreLbl: UILabel!
    @IBOutlet weak var moreImg: UIImageView!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreBackgroundView: UIView!
    @IBOutlet weak var bookingLbl: UILabel!
    @IBOutlet weak var bookingImg: UIImageView!
    @IBOutlet weak var bookingView: UIView!
    @IBOutlet weak var bookingBackgroundView: UIView!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeBackgroundView: UIView!
    
    var onDidClickItem: OnClickTabBarItem?
    var selectedIndex: Int = 0
    var lastSelectedIndex: Int = 0
    var view: UIView!

    var tabBar: UITabBar? {
        didSet {
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    func xibSetup() {
        view = loadNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = bounds
        view.backgroundColor = .clear
        addSubview(view)
        // add Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": view!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": view!]))
        
    }
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
   
    @IBAction func moreBtn(_ sender: Any) {
        moreBackgroundView.backgroundColor = R.color.lightblue()
        moreImg.tintColor = R.color.normalblue()
        moreLbl.textColor = R.color.normalblue()
        homeBackgroundView.backgroundColor = .clear
        homeImg.tintColor = R.color.darkgray2()
        homeLbl.textColor = R.color.darkgray2()
        bookingBackgroundView.backgroundColor = .clear
        bookingImg.tintColor = R.color.darkgray2()
        bookingLbl.textColor = R.color.darkgray2()
        lastSelectedIndex = selectedIndex
        selectedIndex = 2
        onDidClickItem?(2)
    }
    @IBAction func bookingBtn(_ sender: UIButton) {
        bookingBackgroundView.backgroundColor = R.color.lightblue()
        bookingImg.tintColor = R.color.normalblue()
        bookingLbl.textColor = R.color.normalblue()
        homeBackgroundView.backgroundColor = .clear
        homeImg.tintColor = R.color.darkgray2()
        homeLbl.textColor = R.color.darkgray2()
        moreBackgroundView.backgroundColor = .clear
        moreImg.tintColor = R.color.darkgray2()
        moreLbl.textColor = R.color.darkgray2()
        lastSelectedIndex = selectedIndex
        selectedIndex = 1
        onDidClickItem?(1)
    }
    @IBAction func homeBtn(_ sender: UIButton) {
        homeBackgroundView.backgroundColor = R.color.lightblue()
        homeImg.tintColor = R.color.normalblue()
        homeLbl.textColor = R.color.normalblue()
        bookingBackgroundView.backgroundColor = .clear
        bookingImg.tintColor = R.color.darkgray2()
        bookingLbl.textColor = R.color.darkgray2()
        moreBackgroundView.backgroundColor = .clear
        moreImg.tintColor = R.color.darkgray2()
        moreLbl.textColor = R.color.darkgray2()
        lastSelectedIndex = selectedIndex
        selectedIndex = 0
        onDidClickItem?(0)
    }
   
    
}
extension CustomTabBarView {
  
    func setupItemView(for item: UITabBarItem, counter: Int = 0) -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: item.image)
        let label = UILabel()
        label.text = item.title?.localized
        label.font = ThemeApp.Fonts.regularFont(size: 10)
        label.textColor = R.color.black()
        label.alpha = 1
        view.addSubview(imageView)
        imageView.addCenterXConstraint(toView: view)
        imageView.addTopConstraint(toView: view, constant: 10)
        view.addSubview(label)
        label.addBottomConstraint(toView: view, constant: -4)
        label.addCenterXConstraint(toView: view)
        
        if selectedIndex == counter {
            imageView.image = item.selectedImage
            label.textColor = R.color.normalblue()
            label.font = ThemeApp.Fonts.regularFont(size: 10)
            label.alpha = 1
        }
        
        
        let btn = UIButton()
        btn.tag = counter
        view.addSubview(btn)
        btn.fillSuperView()
        self.actionForItem(for: btn)
        
       
        return view
    }
    func actionForItem(for btn: UIButton) {
        btn.addTarget(self, action: #selector(tabBarItemClicked(_:)), for: .touchUpInside)
    }
    
    @objc func tabBarItemClicked(_ btn: UIButton) {
        lastSelectedIndex = selectedIndex

    }
   
}
