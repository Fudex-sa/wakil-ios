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
    @IBOutlet weak var noMatchView: UIView!
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
        setStatusBar(color: R.color.primary()!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reload()
        })
        viewModel?.matchFinish.listen(on: { [weak self] value in
            self?.reloadmatches()
        })
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        changeColoe()
        clubLbl.preferredMaxLayoutWidth = 100
        if UD.club != nil {
            if UD.club?.id == 0 {
                clubLbl.text = "All".localized
            }else {
                clubLbl.text = UD.club?.name ?? ""
            }
            clubLbl.sizeToFit()
        }
        newsTbl.delegate = self
        newsTbl.dataSource = self
        matchesCollection.delegate = self
        matchesCollection.dataSource = self
        viewModel?.countryId.send(1)
        newsTbl.observe()
        newsTbl.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchhome()
        viewModel?.fetchtodaymatch()
        menuBtn.publisher.listen(on: {[weak self] _ in
            self?.openMenu()
        }).store(self)
        clubSelectBtn.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.changeclub()
        }).store(self)
        moreNewsLbl.UIViewAction {
            self.coordinator?.morenews()
        }
        MoreMatchLbl.UIViewAction {
            self.coordinator?.morematches()
        }
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            newsTbl.isHidden = true
            if isMenuOpen == false {
                showEmptyScreen(for: 350 , title: "There are no news available".localized)
            }
        }else {
            newsTbl.isHidden = false
            hideEmptyScreen()
        }
        for index in viewModel?.clubs.value ?? [] {
            if index.id == UD.club?.id ?? 0 {
                clubLbl.text = index.name ?? ""
                UD.club?.name = index.name ?? ""
                clubLbl.sizeToFit()
            }
        }
        newsTbl.reloadData()
        newsTbl.stopSwipeButtom()

    }
    func reloadmatches(){
        if viewModel?.matches.value?.count ?? 0 == 0 {
            matchesCollection.isHidden = true
            noMatchView.isHidden = false
        }else {
            matchesCollection.isHidden = false
            noMatchView.isHidden = true
        }
        matchesCollection.reloadData()
        matchesCollection.stopSwipeButtom()

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
        hideEmptyScreen()
        // Update the leading constraint to animate the side menu
        sideMenuLeadingConstraint.constant = isMenuOpen ? 0 : -sideMenuWidth
        clubSelectBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    func closeMenu() {
            isMenuOpen = false
            if viewModel?.items.value?.count ?? 0 == 0 {
                showEmptyScreen(for: 350 , title: "There are no news available".localized)
            }
            // Update the leading constraint to animate the side menu closure
            sideMenuLeadingConstraint.constant = -sideMenuWidth
            clubSelectBtn.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
    }
    func changeColoe() {
        if UD.club != nil {
            coverView.backgroundColor = UIColor(hex: UD.club?.color ?? "")
            tabBarController?.tabBar.tintColor = UIColor(hex: UD.club?.color ?? "")
            setStatusBar(color:  UIColor(hex: UD.club?.color ?? ""))
        }
    }
}
// MARK: - ...  View Contract
extension HomeVC {
}
extension HomeVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource()?.count ?? 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: NewsTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.delegate = self
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        self.coordinator?.detailsnews(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)

    }

}
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if viewModel?.matches.value?.count ?? 0 > 4 {
              return 4
          }else {
              return viewModel?.matches.value?.count ?? 2
          }
          
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: MatchsHomeCollectionViewCell.self, indexPath)
            cell.model = viewModel?.matches.value?[safe: indexPath.row]
            cell.delegate = self
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.matches.value?.count ?? 0 == 0 {
            return
        }
        coordinator?.detailsmatchs(id: viewModel?.matches.value?[safe: indexPath.row]?.id ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 0
    }
  }

extension HomeVC : MatchsHomeCollectionViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: MatchsHomeCollectionViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
extension HomeVC : NewsTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: NewsTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
