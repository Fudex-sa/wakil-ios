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
    @IBOutlet weak var postsView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var matchesView: UIView!
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var slidersCollection: UICollectionView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var postsTbl: UITableView!
    @IBOutlet weak var newsTbl: UITableView!
    @IBOutlet weak var matchesCollection: UICollectionView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubSelectBtn: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var moreNewsLbl: UILabel!
    @IBOutlet weak var MoreMatchLbl: UILabel!
    @IBOutlet weak var morePostsLbl: UILabel!

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
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
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
        
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.stopSwipeTop()
            self?.reload()
        })
        viewModel?.settingdata.listen(on: { [weak self] value in
            if self?.viewModel?.settingdata.value?.data?.value ?? "" == "1"{
                self?.sideMenuViewController?.subscribeView.isHidden = false
            }else {
                self?.sideMenuViewController?.subscribeView.isHidden = true
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
        slidersCollection.delegate = self
        slidersCollection.dataSource = self
        newsTbl.observe()
        newsTbl.skeleton()
        postsTbl.delegate = self
        postsTbl.dataSource = self
        postsTbl.observe()
        postsTbl.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchhome()
        menuBtn.publisher.listen(on: {[weak self] _ in
            self?.openMenu()
        }).store(self)
        clubSelectBtn.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.changeclub()
        }).store(self)
        MoreMatchLbl.UIViewAction {
            self.coordinator?.morematches()
        }
        swipeTopRefresh(scrollView: containerScrollView) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchhome()
        }
        moreNewsLbl.UIViewAction {
            self.coordinator?.morenews()
        }
        morePostsLbl.UIViewAction {
            self.coordinator?.moreposts()
        }
        MoreMatchLbl.UIViewAction {
            self.coordinator?.morematches()
        }
    }
    
    func reload(){
        for index in viewModel?.clubs.value ?? [] {
            if index.id == UD.club?.id ?? 0 {
                clubLbl.text = index.name ?? ""
                UD.club?.name = index.name ?? ""
                clubLbl.sizeToFit()
            }
        }
        if viewModel?.matches.value?.count ?? 0 == 0 {
            matchesView.isHidden = false
            matchesCollection.isHidden = true
        }else {
            matchesView.isHidden = true
            matchesCollection.isHidden = false
        }
        if viewModel?.items.value?.count ?? 0 == 0 {
            newsView.isHidden = false
            newsTbl.isHidden = true
        }else {
            newsView.isHidden = true
            newsTbl.isHidden = false
        }
        if viewModel?.posts.value?.count ?? 0 == 0 {
            postsView.isHidden = false
            postsTbl.isHidden = true
        }else {
            postsView.isHidden = true
            postsTbl.isHidden = false
        }
        slidersCollection.reloadData()
        newsTbl.reloadData()
        postsTbl.reloadData()
        matchesCollection.reloadData()
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
//        if type == 0 {
//            if viewModel?.events.value?.count ?? 0 == 0 {
//                showEmptyScreen(for: 350 , title: "There are no events available".localized)
//            }
//        }else if type == 2 {
//            if viewModel?.events.value?.count ?? 0 == 0 {
//                showEmptyScreen(for: 350 , title: "There are no news available".localized)
//            }
//        }else if type == 3 {
//            if viewModel?.posts.value?.count ?? 0 == 0 {
//                showEmptyScreen(for: 350 , title: "There are no posts available".localized)
//            }
//        }
           
            // Update the leading constraint to animate the side menu closure
            sideMenuLeadingConstraint.constant = -sideMenuWidth
            clubSelectBtn.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
    }
    func changeColoe() {
        if UD.club != nil {
            tabBarController?.tabBar.tintColor = UIColor(hex: UD.club?.color ?? "")
          //  setStatusBar(color:  UIColor(hex: UD.club?.color ?? ""))
        }
    }
}
// MARK: - ...  View Contract
extension HomeVC {
}
extension HomeVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == newsTbl {
            return viewModel?.dataSource()?.count ?? 2
        }else {
            return viewModel?.posts.value?.count ?? 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == newsTbl{
            var cell = tableView.cell(type: NewsTableViewCell.self, indexPath)
            cell.model = viewModel?.dataSource()?[safe: indexPath.row]
            cell.delegate = self
            cell.setup()
            return cell
        }else {
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
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 && viewModel?.posts.value?.count ?? 0 == 0 {
            return
        }
        if tableView == newsTbl {
            self.coordinator?.detailsnews(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
        }else  {
            self.coordinator?.detailsposts(id: viewModel?.posts.value?[safe: indexPath.row]?.id ?? 0)
        }

    }

}
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == slidersCollection {
            return .init(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            return .init(width: 300, height: collectionView.frame.height)
        }
       }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == slidersCollection {
            pageControll.currentPage = indexPath.row
        }
        }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if collectionView == slidersCollection {
              pageControll.numberOfPages = viewModel?.sliders.value?.count ?? 0
              return viewModel?.sliders.value?.count ?? 2
          }else {
              return viewModel?.matches.value?.count ?? 2
          }
          
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == slidersCollection {
                var cell = collectionView.cell(type: SlidersCollectionViewCell.self, indexPath)
                cell.model = viewModel?.sliders.value?[safe: indexPath.row]
                cell.setup()
                return cell
            }else {
                var cell = collectionView.cell(type: MatchsHomeCollectionViewCell.self, indexPath)
                cell.model = viewModel?.matches.value?[safe: indexPath.row]
                cell.delegate = self
                return cell
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.matches.value?.count ?? 0 == 0 && viewModel?.sliders.value?.count ?? 0 == 0{
            return
        }
        if collectionView == slidersCollection {
            if viewModel?.sliders.value?[safe: indexPath.row]?.link ?? "" != "" {
                Common().openUrl(text: viewModel?.sliders.value?[safe: indexPath.row]?.link ?? "")
            }
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
