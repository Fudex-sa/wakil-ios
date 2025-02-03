//
//  ClubdetailsVC.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ClubdetailsVC: BaseController {
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var prizesTbl: UITableView!
    @IBOutlet weak var tableTbl: UITableView!
    @IBOutlet weak var playerCollection: UICollectionView!
    @IBOutlet weak var tableLineView: UIView!
    @IBOutlet weak var tableLbl: UILabel!
    @IBOutlet weak var tableClickView: UIView!
    @IBOutlet weak var infoLineView: UIView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var infoClickView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var viewModel: ClubdetailsViewModel?
    var coordinator: ClubdetailsCoordinator?
    var clubId = 0
    var type = 0

}

// MARK: - ...  LifeCycle
extension ClubdetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
       // setStatusBar(color:  UIColor(hex: UD.club?.color ?? "#E51D35"))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
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
        
        viewModel?.clubdata.listen(on: { [weak self] value in
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension ClubdetailsVC {
    func setup() {
        tableTbl.delegate = self
        tableTbl.dataSource = self
        tableTbl.observe()
        tableTbl.skeleton()
        prizesTbl.delegate = self
        prizesTbl.dataSource = self
        prizesTbl.observe()
        prizesTbl.skeleton()
        playerCollection.delegate = self
        playerCollection.dataSource = self
        playerCollection.observe()
        playerCollection.skeleton()
        startLoading()
        viewModel?.clubId.send(clubId)
        viewModel?.getclubdetails()
      //  backgroundView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        if type == 0 {
            infoLbl.textColor = R.color.primary()
            infoLineView.backgroundColor = R.color.primary()
            infoLineView.isHidden = false
            tableLbl.textColor = UIColor(hex: "#D9D9D9")
            tableLineView.backgroundColor = R.color.primary()
            tableLineView.isHidden = true
        }else {
            tableLbl.textColor = R.color.primary()
            tableLineView.backgroundColor = R.color.primary()
            tableLineView.isHidden = false
            infoLbl.textColor = UIColor(hex: "#D9D9D9")
            infoLineView.backgroundColor = R.color.primary()
            infoLineView.isHidden = true
        }
        infoClickView.publisherGesture.listen(on: {[weak self] _ in
            self?.infoLbl.textColor = R.color.primary()
            self?.infoLineView.backgroundColor = R.color.primary()
            self?.infoLineView.isHidden = false
            self?.tableLbl.textColor = UIColor(hex: "#D9D9D9")
            self?.tableLineView.backgroundColor = R.color.primary()
            self?.tableLineView.isHidden = true
            self?.tableView.isHidden = true
            self?.infoView.isHidden = false
        }).store(self)
        tableClickView.publisherGesture.listen(on: {[weak self] _ in
            self?.tableLbl.textColor = R.color.primary()
            self?.tableLineView.backgroundColor = R.color.primary()
            self?.tableLineView.isHidden = false
            self?.infoLbl.textColor = UIColor(hex: "#D9D9D9")
            self?.infoLineView.backgroundColor = R.color.primary()
            self?.infoLineView.isHidden = true
            self?.tableView.isHidden = false
            self?.infoView.isHidden = true
        }).store(self)
    }
    func reload() {
        stopLoading()
        clubLbl.text = viewModel?.clubdata.value?.data?.name ?? ""
        if viewModel?.clubdata.value?.data?.foundationDate ?? "" != "" {
            dateLbl.text = "\("Established for the year".localized) \(viewModel?.clubdata.value?.data?.foundationDate ?? "") \("AH".localized)"
        }else {
            dateLbl.text = ""
        }
        clubImg.setImage(url: viewModel?.clubdata.value?.data?.photo ?? "")
        desLbl.text = viewModel?.clubdata.value?.data?.generalInfo ?? ""
        tableTbl.reloadData()
        prizesTbl.reloadData()
        playerCollection.reloadData()
    }
}
// MARK: - ...  View Contract
extension ClubdetailsVC {
}
extension ClubdetailsVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == prizesTbl {
            return viewModel?.clubdata.value?.data?.prizes?.count ?? 0
        }else {
            return viewModel?.clubdata.value?.data?.standing?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == prizesTbl {
            var cell = tableView.cell(type: PrizesTableViewCell.self, indexPath)
            cell.model = viewModel?.clubdata.value?.data?.prizes?[safe: indexPath.row]
            cell.setup()
            return cell
        }else {
            var cell = tableView.cell(type: TableTableViewCell.self, indexPath)
            cell.model = viewModel?.clubdata.value?.data?.standing?[safe: indexPath.row]
            cell.setup()
            return cell
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
extension ClubdetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = collectionViewWidth / 2 - 10
        return CGSize(width: itemWidth , height: 56)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel?.clubdata.value?.data?.players?.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: PlayersCollectionViewCell.self, indexPath)
            cell.model = viewModel?.clubdata.value?.data?.players?[safe: indexPath.row]
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
  }
