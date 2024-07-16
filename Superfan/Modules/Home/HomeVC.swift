//
//  HomeVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class HomeVC: BaseController {
    @IBOutlet weak var newsTbl: UITableView!
    @IBOutlet weak var matchesCollection: UICollectionView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubSelectBtn: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var moreNewsLbl: UILabel!
    @IBOutlet weak var MoreMatchLbl: UILabel!
    @IBOutlet weak var coverView: UIView!
    var viewModel: HomeViewModel?
    var coordinator: HomeCoordinator?
    let sideMenuWidth: CGFloat = 300 // Adjust the width of the side menu as needed
    var sideMenuLeadingConstraint: NSLayoutConstraint!
    var isMenuOpen = false
    var sideMenuViewController: SlideMenuVC?
    let cellWidth: CGFloat = 320 // Width of each cell
}

// MARK: - ...  LifeCycle
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        menuBtn.publisher.listen(on: {[weak self] _ in
            self?.openMenu()
        }).store(self)
    }
    func setupSideMenu() {
        let storyboard = R.storyboard.slideMenuStoryboard()
        sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SlideMenuVC") as? SlideMenuVC
        addChild(sideMenuViewController!)
        view.addSubview(sideMenuViewController!.view)
        sideMenuViewController!.didMove(toParent: self)
                
                // Set initial constraints for side menu
        sideMenuViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        sideMenuLeadingConstraint = sideMenuViewController!.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuWidth)
        NSLayoutConstraint.activate([
            sideMenuViewController!.view.topAnchor.constraint(equalTo: view.topAnchor),
            sideMenuViewController!.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuLeadingConstraint,
            sideMenuViewController!.view.widthAnchor.constraint(equalToConstant:sideMenuWidth)
        ])
        }
    func openMenu() {
        isMenuOpen.toggle()
        
        // Update the leading constraint to animate the side menu
        sideMenuLeadingConstraint.constant = isMenuOpen ? 0 : -sideMenuWidth
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    func closeMenu() {
            isMenuOpen = false

            // Update the leading constraint to animate the side menu closure
            sideMenuLeadingConstraint.constant = -sideMenuWidth

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
    }
}
// MARK: - ...  View Contract
extension HomeVC {
}
