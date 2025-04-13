//
//  ReservationTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class ReservationTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var servicesCollection: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    var homedata: ReservationDatum?

    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? ReservationDatum else { return }
        homedata = model
        dateLbl.text = model.date ?? ""
        timeLbl.text = model.time ?? ""
        var title = ""
        var item = 0
        for index in model.service ?? [] {
            if item == (model.service?.count ?? 0 ) - 1 {
                title = "\(title) \(index.name ?? "")"
            }else {
                title = "\(title) \(index.name ?? "") - "
            }
            item = item + 1
        }
        titleLbl.text = title
        if model.is_gift ?? 0 == 1 {
            homedata?.serviceTypes?.append("".localized)
        }
        servicesCollection.skeleton()
        servicesCollection.delegate = self
        servicesCollection.dataSource = self
        servicesCollection.observe()
    }
}
extension ReservationTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: servicesCollection.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return homedata?.serviceTypes?.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ServicetypeCollectionViewCell.self, indexPath)
            cell.model = homedata?.serviceTypes?[safe: indexPath.row]
            cell.setup()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
   
  }
