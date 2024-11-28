//
//  HomeVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// MARK: - ...  ViewController - Vars
class HomeVC: BaseController,Reloader {
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var matchesView: UIView!
    @IBOutlet weak var noresultNextView: UIView!
    @IBOutlet weak var postsTbl: UITableView!
    @IBOutlet weak var tableTbl: UITableView!
    @IBOutlet weak var nextCollection: UICollectionView!
    @IBOutlet weak var eventsTbl: UITableView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var postsshowView: UIView!
    @IBOutlet weak var postsLbl: UILabel!
    @IBOutlet weak var postsClickView: UIView!
    @IBOutlet weak var newsshowView: UIView!
    @IBOutlet weak var newsLbl: UILabel!
    @IBOutlet weak var newsClickView: UIView!
    @IBOutlet weak var matchesshowView: UIView!
    @IBOutlet weak var matchesLbl: UILabel!
    @IBOutlet weak var matcheClickView: UIView!
    @IBOutlet weak var eventshowView: UIView!
    @IBOutlet weak var eventLbl: UILabel!
    @IBOutlet weak var eventClickView: UIView!
    @IBOutlet weak var notBtn: UIButton!
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
    static var itemId: Int?
    static var type: String?
    var type = 0
    var expandedStates = [Bool]()
}

// MARK: - ...  LifeCycle
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        //setStatusBar(color: R.color.primary()!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = false
        subscribe()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        unsubscribe()
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.eventsfinish.listen(on: { [weak self] value in
            if self?.type != 0 {
                return
            }
            self?.stopSwipeTop()
            self?.reload()
        })
        viewModel?.matchFinish.listen(on: { [weak self] value in
            self?.stopSwipeTop()
            self?.reloadmatches()
        })
        viewModel?.matchFinishtab.listen(on: { [weak self] value in
            if self?.type != 1 {
                return
            }
            self?.stopSwipeTop()
            self?.reloadmatchestabs()
        })
        viewModel?.newsfinish.listen(on: { [weak self] value in
            if self?.type != 2 {
                return
            }
            self?.stopSwipeTop()
            self?.reloadnews()
        })
        viewModel?.postsfinish.listen(on: { [weak self] value in
            if self?.type != 3 {
                return
            }
            self?.stopSwipeTop()
            self?.reloadposts()
        })
        viewModel?.settingdata.listen(on: { [weak self] value in
            if self?.viewModel?.settingdata.value?.data?.value ?? "" == "1"{
                self?.sideMenuViewController?.subscribeView.isHidden = false
                self?.sideMenuViewController?.subscribeTop.constant = 20
                self?.sideMenuViewController?.subscribeHight.constant = 35
            }else {
                self?.sideMenuViewController?.subscribeView.isHidden = true
                self?.sideMenuViewController?.subscribeTop.constant = 0
                self?.sideMenuViewController?.subscribeHight.constant = 0
            }
        })
        viewModel?.likedata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.likedata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
        })
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        viewModel?.countryId.send(1)
        viewModel?.fetchsetting()
        if type == 0 {
            showevents()
        }else if type == 1 {
           showmatches()
        }else if type == 2 {
           shownews()
        }else if type == 3 {
           showposts()
        }
        if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "match_events"{
            coordinator?.detailsmatchs(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "news"{
            coordinator?.detailsnews(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "likePost"{
            coordinator?.detailsposts(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "commentPost"{
            coordinator?.comments(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "likePostComment"{
            coordinator?.comments(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "replyPost"{
            coordinator?.reply(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "likeBackstageComment"{
            coordinator?.detailsbackstages(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "replyBackstage"{
            coordinator?.reply(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }
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
        Messaging.messaging().subscribe(toTopic: NetworkConfigration.Config.firebaseTopic) { error in
                if let error = error {
                    print("Failed to subscribe to topic: \(error.localizedDescription)")
                } else {
                    print("Subscribed to topic: your_topic_name")
                }
        }
        containerScrollView.delegate = self
        newsTbl.delegate = self
        newsTbl.dataSource = self
        matchesCollection.delegate = self
        matchesCollection.dataSource = self
        nextCollection.delegate = self
        nextCollection.dataSource = self
        newsTbl.observe()
        newsTbl.skeleton()
        tableTbl.delegate = self
        tableTbl.dataSource = self
        tableTbl.observe()
        tableTbl.skeleton()
        postsTbl.delegate = self
        postsTbl.dataSource = self
        postsTbl.observe()
        postsTbl.skeleton()
        eventsTbl.delegate = self
        eventsTbl.dataSource = self
        eventsTbl.observe()
        eventsTbl.skeleton()
        menuBtn.publisher.listen(on: {[weak self] _ in
            self?.openMenu()
        }).store(self)
        clubSelectBtn.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.changeclub()
        }).store(self)
        notBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.notification()
        }).store(self)
        MoreMatchLbl.UIViewAction {
            self.coordinator?.morematches()
        }
        eventClickView.publisherGesture.listen(on: {[weak self] _ in
            if self?.type != 0 {
                self?.type = 0
                self?.showevents()
            }
        }).store(self)
        matcheClickView.publisherGesture.listen(on: {[weak self] _ in
            if self?.type != 1 {
                self?.type = 1
                self?.showmatches()
            }
        }).store(self)
        newsClickView.publisherGesture.listen(on: {[weak self] _ in
            if self?.type != 2 {
                self?.type = 2
                self?.shownews()
            }
        }).store(self)
        postsClickView.publisherGesture.listen(on: {[weak self] _ in
            if self?.type != 3 {
                self?.type = 3
                self?.showposts()
            }
        }).store(self)
        swipeTopRefresh(scrollView: containerScrollView) { [weak self] in
            if self?.type == 0 {
                self?.showevents()
            }else if self?.type == 1 {
                self?.showmatches()
            }else if self?.type == 2 {
                self?.shownews()
            }else if self?.type == 3 {
                self?.showposts()
            }
        }
    }
    func showevents(){
        eventLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        eventshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        eventshowView.isHidden = false
        matchesLbl.textColor = UIColor(hex: "#353535")
        matchesshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        matchesshowView.isHidden = true
        newsLbl.textColor = UIColor(hex: "#353535")
        newsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        newsshowView.isHidden = true
        postsLbl.textColor = UIColor(hex: "#353535")
        postsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        postsshowView.isHidden = true
        eventsView.isHidden = false
        matchesView.isHidden = true
        newsTbl.isHidden = true
        postsTbl.isHidden = true
        expandedStates.removeAll()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchhome()
        hideEmptyScreen()
    }
    func showmatches(){
        matchesLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        matchesshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        matchesshowView.isHidden = false
        eventLbl.textColor = UIColor(hex: "#353535")
        eventshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        eventshowView.isHidden = true
        newsLbl.textColor = UIColor(hex: "#353535")
        newsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        newsshowView.isHidden = true
        postsLbl.textColor = UIColor(hex: "#353535")
        postsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        postsshowView.isHidden = true
        eventsView.isHidden = true
        matchesView.isHidden = false
        newsTbl.isHidden = true
        postsTbl.isHidden = true
        expandedStates.removeAll()
        viewModel?.fetchmatchtab()
        hideEmptyScreen()
    }
    func shownews(){
        newsLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        newsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        newsshowView.isHidden = false
        eventLbl.textColor = UIColor(hex: "#353535")
        eventshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        eventshowView.isHidden = true
        matchesLbl.textColor = UIColor(hex: "#353535")
        matchesshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        matchesshowView.isHidden = true
        postsLbl.textColor = UIColor(hex: "#353535")
        postsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        postsshowView.isHidden = true
        eventsView.isHidden = true
        matchesView.isHidden = true
        newsTbl.isHidden = false
        postsTbl.isHidden = true
        expandedStates.removeAll()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchnews()
        hideEmptyScreen()
    }
    func showposts(){
        postsLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        postsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        postsshowView.isHidden = false
        eventLbl.textColor = UIColor(hex: "#353535")
        eventshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        eventshowView.isHidden = true
        newsLbl.textColor = UIColor(hex: "#353535")
        newsshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        newsshowView.isHidden = true
        matchesLbl.textColor = UIColor(hex: "#353535")
        matchesshowView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        matchesshowView.isHidden = true
        eventsView.isHidden = true
        matchesView.isHidden = true
        newsTbl.isHidden = true
        postsTbl.isHidden = false
        expandedStates.removeAll()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.posts.send([])
        viewModel?.fetchposts()
        hideEmptyScreen()
    }
    func reload(){
        if viewModel?.events.value?.count ?? 0 == 0 {
            eventsTbl.isHidden = true
            if isMenuOpen == false {
                showEmptyScreen(for: 350 , title: "There are no events available".localized)
            }
        }else {
            eventsTbl.isHidden = false
            hideEmptyScreen()
        }
        for index in viewModel?.clubs.value ?? [] {
            if index.id == UD.club?.id ?? 0 {
                clubLbl.text = index.name ?? ""
                UD.club?.name = index.name ?? ""
                clubLbl.sizeToFit()
            }
        }
        self.expandedStates.append(contentsOf: [Bool](repeating: false, count: viewModel?.events.value?.count ?? 0))
        eventsTbl.reloadData()
        eventsTbl.stopSwipeButtom()
        reloadmatches()

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
    func reloadmatchestabs(){
        if viewModel?.matchestab.value?.data?.nextMatches?.count ?? 0 == 0 {
            nextCollection.isHidden = true
            noresultNextView.isHidden = false
        }else {
            nextCollection.isHidden = false
            noresultNextView.isHidden = true
        }
        nextCollection.reloadData()
        tableTbl.reloadData()
        nextCollection.stopSwipeButtom()

    }
    func reloadnews(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            newsTbl.isHidden = true
            if isMenuOpen == false {
                showEmptyScreen(for: 350 , title: "There are no news available".localized)
            }
        }else {
            newsTbl.isHidden = false
            hideEmptyScreen()
        }
        newsTbl.reloadData()
        newsTbl.stopSwipeButtom()

    }
    func reloadposts(){
        if viewModel?.posts.value?.count ?? 0 == 0 {
            postsTbl.isHidden = true
            if isMenuOpen == false {
                showEmptyScreen(for: 350 , title: "There are no posts available".localized)
            }
        }else {
            postsTbl.isHidden = false
            hideEmptyScreen()
        }
        self.expandedStates.append(contentsOf: [Bool](repeating: false, count: viewModel?.posts.value?.count ?? 0))
        postsTbl.reloadData()
        postsTbl.stopSwipeButtom()

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
        if type == 0 {
            if viewModel?.events.value?.count ?? 0 == 0 {
                showEmptyScreen(for: 350 , title: "There are no events available".localized)
            }
        }else if type == 2 {
            if viewModel?.events.value?.count ?? 0 == 0 {
                showEmptyScreen(for: 350 , title: "There are no news available".localized)
            }
        }else if type == 3 {
            if viewModel?.posts.value?.count ?? 0 == 0 {
                showEmptyScreen(for: 350 , title: "There are no posts available".localized)
            }
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
          //  setStatusBar(color:  UIColor(hex: UD.club?.color ?? ""))
            sideMenuViewController?.containerView.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension HomeVC {
}
extension HomeVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if type == 2 {
            if scrollView == containerScrollView {
                let tableViewVisibleHeight = containerScrollView.bounds.size.height
                   let tableViewContentHeight = containerScrollView.contentSize.height
                   let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
                   
                if scrollView.contentOffset.y > tableViewOffsetThreshold && containerScrollView.isDragging {
                    // Fetch more data here
                    if case self.viewModel?.canPaginate() = true {
                        self.viewModel?.fetchnews()
                    }
                }
            }
        }else if type == 3 {
            if scrollView == containerScrollView {
                let tableViewVisibleHeight = containerScrollView.bounds.size.height
                   let tableViewContentHeight = containerScrollView.contentSize.height
                   let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
                   
                if scrollView.contentOffset.y > tableViewOffsetThreshold && containerScrollView.isDragging {
                    // Fetch more data here
                    if case self.viewModel?.canPaginate() = true {
                        self.viewModel?.fetchposts()
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == newsTbl {
            return viewModel?.dataSource()?.count ?? 2
        }else  if tableView == tableTbl {
            return viewModel?.matchestab.value?.data?.standing?.count ?? 0
        }else  if tableView == postsTbl {
            return viewModel?.posts.value?.count ?? 2
        }else {
            return viewModel?.events.value?.count ?? 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == newsTbl{
            var cell = tableView.cell(type: NewsTableViewCell.self, indexPath)
            cell.model = viewModel?.dataSource()?[safe: indexPath.row]
            cell.delegate = self
            cell.setup()
            return cell
        }else if tableView == tableTbl {
            var cell = tableView.cell(type: TableTableViewCell.self, indexPath)
            cell.model = viewModel?.matchestab.value?.data?.standing?[safe: indexPath.row]
            cell.setup()
            return cell
        }else if tableView == postsTbl {
            var cell = tableView.cell(type: PostsTableViewCell.self, indexPath)
            cell.model = viewModel?.posts.value?[safe: indexPath.row]
            if expandedStates.count != 0 {
                let isExpanded = expandedStates[indexPath.item]
                let text = viewModel?.posts.value?[safe: indexPath.row]?.description ?? ""
                cell.configure(with: text, isExpanded: isExpanded) {
                    self.expandedStates[indexPath.item] = !self.expandedStates[indexPath.item]
                    self.postsTbl.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            cell.setup()
            cell.delegate = self
            return cell
        }else{
            if viewModel?.events.value?[safe: indexPath.row]?.type ?? "" == "news" {
                var cell = tableView.cell(type: NewsTableViewCell.self, indexPath)
                cell.model = viewModel?.events.value?[safe: indexPath.row]
                cell.delegate = self
                cell.setuphome()
                return cell
            }else {
                var cell = tableView.cell(type: PostsTableViewCell.self, indexPath)
                cell.model = viewModel?.events.value?[safe: indexPath.row]
                if expandedStates.count != 0 {
                    let isExpanded = expandedStates[indexPath.item]
                    let text = viewModel?.events.value?[safe: indexPath.row]?.description ?? ""
                    cell.configure(with: text, isExpanded: isExpanded) {
                        self.expandedStates[indexPath.item] = !self.expandedStates[indexPath.item]
                        self.postsTbl.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                cell.setup()
                cell.delegate = self
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 && viewModel?.posts.value?.count ?? 0 == 0 && viewModel?.events.value?.count ?? 0 == 0{
            return
        }
        if tableView == newsTbl {
            self.coordinator?.detailsnews(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
        }else if tableView == postsTbl {
            self.coordinator?.detailsposts(id: viewModel?.posts.value?[safe: indexPath.row]?.id ?? 0)
        }else {
            if viewModel?.events.value?[safe: indexPath.row]?.type ?? "" == "news" {
                self.coordinator?.detailsnews(id: viewModel?.events.value?[safe: indexPath.row]?.id ?? 0)

            }else {
                self.coordinator?.detailsposts(id: viewModel?.events.value?[safe: indexPath.row]?.id ?? 0)

            }
        }

    }

}
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if collectionView == nextCollection {
              return viewModel?.matchestab.value?.data?.nextMatches?.count ?? 2
          }else {
              if viewModel?.matches.value?.count ?? 0 > 4 {
                  return 4
              }else {
                  return viewModel?.matches.value?.count ?? 2
              }
          }
          
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == nextCollection {
                var cell = collectionView.cell(type: NextmatchesCollectionViewCell.self, indexPath)
                cell.model = viewModel?.matchestab.value?.data?.nextMatches?[safe: indexPath.row]
                cell.delegate = self
                return cell
            }else {
                var cell = collectionView.cell(type: MatchsHomeCollectionViewCell.self, indexPath)
                cell.model = viewModel?.matches.value?[safe: indexPath.row]
                cell.delegate = self
                return cell
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.matches.value?.count ?? 0 == 0 && viewModel?.matchestab.value?.data?.nextMatches?.count ?? 0 == 0{
            return
        }
        if collectionView == nextCollection {
            coordinator?.detailsmatchs(id: viewModel?.matchestab.value?.data?.nextMatches?[safe: indexPath.row]?.id ?? 0)
        }else {
            coordinator?.detailsmatchs(id: viewModel?.matches.value?[safe: indexPath.row]?.id ?? 0)
        }
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
extension HomeVC : NextmatchesCollectionViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: NextmatchesCollectionViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
extension HomeVC : PostsTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: PostsTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
    func favoraite(wasPressedOnCell cell: PostsTableViewCell, model: PostsDatum) {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
        }else {
            startLoading()
            viewModel?.postId.send(model.id ?? 0)
            if model.is_liked == 1 {
                viewModel?.unlikepost()
            }else {
                viewModel?.likepost()
            }
        }
    }
    func comments(wasPressedOnCell cell: PostsTableViewCell, model: PostsDatum) {
        coordinator?.comments(id: model.id ?? 0)
    }
}
extension HomeVC : NewsTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: NewsTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
extension HomeVC: NotificationSubscriber {
    func notificationControlWillPresent(notificationType: String?, json: String, closure: SoundHandler?) {
        closure?(true)
        if notificationType ?? "" != "match_events" {
            return
        }
//        viewModel?.resetPaginator()
//        viewModel?.clearDataSource()
//        viewModel?.fetchtodaymatch()
    }
}
