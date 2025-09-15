//
//  CentersTableViewCell.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class CentersTableViewCell: BaseTableViewCell {
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var distanceImg: UIImageView!
    @IBOutlet weak var distanceTitleLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var servicesCollection: UICollectionView!
    @IBOutlet weak var desLbl: UILabel!
    var homedata: HomeDatum?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? HomeDatum else { return }
        homedata = model
        centerImg.setImage(url: model.image ?? "")
        distance.text = model.distance ?? ""
        titleLbl.text = model.name ?? ""
        rateLbl.text = model.rate?.string ?? ""
        desLbl.text = model.description ?? ""
        if model.rate ?? 0 == 0 {
            rateLbl.isHidden = true
            starImg.isHidden = true
        }else {
            rateLbl.isHidden = false
            starImg.isHidden = false
        }
        if model.distance ?? "" == "" {
            distanceTitleLbl.isHidden = true
            distance.isHidden = true
            distanceImg.isHidden = true
        }else {
            distanceTitleLbl.isHidden = false
            distance.isHidden = false
            distanceImg.isHidden = false
        }
        servicesCollection.skeleton()
        servicesCollection.delegate = self
        servicesCollection.dataSource = self
        servicesCollection.observe()
        if let layout = servicesCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}
extension CentersTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text =  homedata?.serviceTypes?[safe: indexPath.item]?.name
        label.sizeToFit()
        return CGSize(width:  label.frame.width + 10 , height: servicesCollection.height)
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
