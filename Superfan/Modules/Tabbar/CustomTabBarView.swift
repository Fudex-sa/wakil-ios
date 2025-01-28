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
    @IBOutlet weak var backstage1Img: UIImageView!
    @IBOutlet weak var backstageCircleView: UIView!
    @IBOutlet weak var mypost1Img: UIImageView!
    @IBOutlet weak var mypostsCircleView: UIView!
    @IBOutlet weak var league1Img: UIImageView!
    @IBOutlet weak var leagueCircleView: UIView!
    @IBOutlet weak var home1Img: UIImageView!
    @IBOutlet weak var homeCircleView: UIView!
    @IBOutlet weak var backageImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var leagueView: UIView!
    @IBOutlet weak var mypostsImg: UIImageView!
    @IBOutlet weak var mypostsView: UIView!
    @IBOutlet weak var backstageImg: UIImageView!
    @IBOutlet weak var backstageView: UIView!
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
    
    @IBAction func backstageBtn(_ sender: UIButton) {
        backageImg.image = UIImage(named: "backstage")
        homeCircleView.isHidden = true
        home1Img.isHidden = false
        leagueCircleView.isHidden = true
        league1Img.isHidden = false
        mypostsCircleView.isHidden = true
        mypost1Img.isHidden = false
        backstageCircleView.isHidden = false
        backstage1Img.isHidden = true
        lastSelectedIndex = selectedIndex
        selectedIndex = 3
        onDidClickItem?(3)
    }
    @IBAction func mypostsBtn(_ sender: Any) {
        backageImg.image = UIImage(named: "posts")
        homeCircleView.isHidden = true
        home1Img.isHidden = false
        leagueCircleView.isHidden = true
        league1Img.isHidden = false
        mypostsCircleView.isHidden = false
        mypost1Img.isHidden = true
        backstageCircleView.isHidden = true
        backstage1Img.isHidden = false
        lastSelectedIndex = selectedIndex
        selectedIndex = 2
        onDidClickItem?(2)
    }
    @IBAction func leagueBtn(_ sender: UIButton) {
        backageImg.image = UIImage(named: "leagues")
        homeCircleView.isHidden = true
        home1Img.isHidden = false
        leagueCircleView.isHidden = false
        league1Img.isHidden = true
        mypostsCircleView.isHidden = true
        mypost1Img.isHidden = false
        backstageCircleView.isHidden = true
        backstage1Img.isHidden = false
        lastSelectedIndex = selectedIndex
        selectedIndex = 1
        onDidClickItem?(1)
    }
    @IBAction func homeBtn(_ sender: UIButton) {
        backageImg.image = UIImage(named: "home")
        homeCircleView.isHidden = false
        home1Img.isHidden = true
        leagueCircleView.isHidden = true
        league1Img.isHidden = false
        mypostsCircleView.isHidden = true
        mypost1Img.isHidden = false
        backstageCircleView.isHidden = true
        backstage1Img.isHidden = false
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
            label.textColor = R.color.primary()
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
