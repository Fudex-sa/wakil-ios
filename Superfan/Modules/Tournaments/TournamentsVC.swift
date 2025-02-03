//
//  TournamentsVC.swift
//  Superfan
//
//  Created by ADAM on 24/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class TournamentsVC: BaseController {
    @IBOutlet weak var scrollContainerView: UIScrollView!
    @IBOutlet weak var tableTbl: UITableView!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var matchesView: UIView!
    @IBOutlet weak var perviousTbl: UITableView!
    @IBOutlet weak var upcommingCollection: UICollectionView!
    @IBOutlet weak var tableBtn: UIButton!
    @IBOutlet weak var matchesBtn: UIButton!
    @IBOutlet weak var leagueCollection: UICollectionView!
    var viewModel: TournamentsViewModel?
    var coordinator: TournamentsCoordinator?
    var type = 0
    var standingType = 0

}

// MARK: - ...  LifeCycle
extension TournamentsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator = .init()
        coordinator?.view = self
        bind()
        click()
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.requestFinished = .init()
        viewModel?.publishleague = .init()
        viewModel?.publishstanding = .init()
        viewModel?.publishupcomming = .init()
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.requestFinished.listen(on: { [weak self] value in
           // self?.stopSwipeTop()
            self?.perviousTbl.reloadData()
        })
        viewModel?.publishleague.listen(on: { [weak self] value in
           // self?.stopSwipeTop()
            self?.viewModel?.leagueId.send(self?.viewModel?.leagues.value?[safe: 0]?.id ?? 0)
            self?.standingType = self?.viewModel?.leagues.value?[safe: 0]?.type ?? 0
            self?.leagueCollection.reloadData()
            self?.clickBtn()
        })
        viewModel?.publishupcomming.listen(on: { [weak self] value in
           // self?.stopSwipeTop()
            self?.upcommingCollection.reloadData()
        })
        viewModel?.publishstanding.listen(on: { [weak self] value in
           // self?.stopSwipeTop()
            self?.tableTbl.reloadData()
        })
    }
}
// MARK: - ...  Functions
extension TournamentsVC {
    func setup() {
        scrollContainerView.delegate = self
        perviousTbl.delegate = self
        perviousTbl.dataSource = self
        perviousTbl.observe()
        perviousTbl.skeleton()
        tableTbl.delegate = self
        tableTbl.dataSource = self
        tableTbl.observe()
        tableTbl.skeleton()
        leagueCollection.delegate = self
        leagueCollection.dataSource = self
        upcommingCollection.delegate = self
        upcommingCollection.dataSource = self
        tableTbl.delegate = self
        tableTbl.dataSource = self
        tableTbl.observe()
        tableTbl.skeleton()
        viewModel?.fetchleagues()
    }
    func click() {
        matchesBtn.publisher.listen(on: {[weak self] _ in
            if self?.type ?? 0 != 0 {
                self?.type = 0
                self?.clickBtn()
            }
        }).store(self)
        tableBtn.publisher.listen(on: {[weak self] _ in
            if self?.type ?? 0 != 1 {
                self?.type = 1
                self?.clickBtn()
            }
        }).store(self)
    }
    func clickBtn() {
        if type == 0 {
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.upcomming.send([])
            matchesBtn.backgroundColor = R.color.textfileldbackground()
            matchesBtn.borderColor = R.color.primary()
            matchesBtn.setTitleColor(R.color.darkgray(), for: .normal)
            tableBtn.backgroundColor = R.color.secondary1()
            tableBtn.borderColor = R.color.textfileldbackground()
            tableBtn.setTitleColor(R.color.darkwhite(), for: .normal)
            viewModel?.fetchtodaymatch()
            viewModel?.fetchperviousymatch()
            matchesView.isHidden = false
            tableView.isHidden = true
        }else {
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            tableBtn.backgroundColor = R.color.textfileldbackground()
            tableBtn.borderColor = R.color.primary()
            tableBtn.setTitleColor(R.color.darkgray(), for: .normal)
            matchesBtn.backgroundColor = R.color.secondary1()
            matchesBtn.borderColor = R.color.textfileldbackground()
            matchesBtn.setTitleColor(R.color.darkwhite(), for: .normal)
            matchesView.isHidden = true
            tableView.isHidden = false
            if standingType == 1 {
                viewModel?.standings.send([])
                viewModel?.fetchstandings()
            }else if standingType == 2 {
                viewModel?.standings.send([])
                viewModel?.fetchstandingsmulti()
            }
           
        }
    }
}
// MARK: - ...  View Contract
extension TournamentsVC {
}
extension TournamentsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == leagueCollection {
            return .init(width: 120, height: leagueCollection.height)
        }else {
            return .init(width: 300, height: upcommingCollection.height)
        }
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if collectionView == leagueCollection {
              return viewModel?.leagues.value?.count ?? 0
          }else {
              return viewModel?.upcomming.value?.count ?? 0
          }
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == leagueCollection {
                var cell = collectionView.cell(type: LeguesCollectionViewCell.self, indexPath)
                cell.model = viewModel?.leagues.value?[safe: indexPath.row]
                cell.leagueId = viewModel?.leagueId.value ?? 0
                cell.setup()
                cell.delegate = self
                return cell
            }else {
                var cell = collectionView.cell(type: MatchsHomeCollectionViewCell.self, indexPath)
                cell.model = viewModel?.upcomming.value?[safe: indexPath.row]
                cell.setup()
                return cell
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        if collectionView == upcommingCollection {
            coordinator?.detailsmatchs(id: viewModel?.upcomming.value?[safe: indexPath.row]?.id ?? 0)
        }
        
    }
   
  }

extension TournamentsVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if type == 1 {
            return
        }
    if scrollView == scrollContainerView {
        let tableViewVisibleHeight = scrollContainerView.bounds.size.height
           let tableViewContentHeight = scrollContainerView.contentSize.height
           let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
           
        if scrollView.contentOffset.y > tableViewOffsetThreshold && scrollContainerView.isDragging {
            // Fetch more data here
            if case self.viewModel?.canPaginate() = true {
                self.viewModel?.fetchperviousymatch()
            }
        }
    }
}
func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if type == 1 {
        return
    }
    if scrollView == scrollContainerView {
        scrollView.swipeButtomRefresh { [weak self] in
            if case self?.viewModel?.canPaginate() = true {
                self?.viewModel?.fetchperviousymatch()
            } else {
                scrollView.stopSwipeButtom()
            }
        }
    }
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableTbl {
            return viewModel?.standings.value?.count ?? 0
        }else {
            return viewModel?.dataSource()?.count ?? 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableTbl {
            var cell = tableView.cell(type: StandingTableViewCell.self, indexPath)
            cell.model = viewModel?.standings.value?[safe: indexPath.row]
            cell.setup()
            return cell
        }else {
            var cell = tableView.cell(type: MatchesTableViewCell.self, indexPath)
            cell.model = viewModel?.dataSource()?[safe: indexPath.row]
            cell.setup()
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        coordinator?.detailsmatchs(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
       
    }

}
extension TournamentsVC : MatchesTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: MatchesTableViewCell, clubId: Int) {
        //coordinator?.detailsclub(id: clubId)
    }
}
extension TournamentsVC : MatchsHomeCollectionViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: MatchsHomeCollectionViewCell, clubId: Int) {
       // coordinator?.detailsclub(id: clubId)
    }
}
extension TournamentsVC : LeguesCollectionViewCellDelegate{
    func select(wasPressedOnCell cell: LeguesCollectionViewCell, leagueId: Int, type: Int) {
        viewModel?.leagueId.send(leagueId)
        leagueCollection.reloadData()
        standingType = type
        if type == 3 {
            self.type = 0
            tableBtn.isHidden = true
            matchesBtn.isHidden = true
        }else {
            self.type = 0
            tableBtn.isHidden = false
            matchesBtn.isHidden = false
        }
        clickBtn()
    }
    
    
}
