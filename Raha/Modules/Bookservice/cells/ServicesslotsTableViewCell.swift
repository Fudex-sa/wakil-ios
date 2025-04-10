//
//  ServicesslotsTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol ServicesslotsTableViewCellDelegate: AnyObject {
    func selectservice(wasPressedOnCell cell: ServicesslotsTableViewCell , model : SlotsDatum)
    func selectslot(wasPressedOnCell cell: ServicesslotsTableViewCell , model : [Slot] , serviceId : Int)
}
class ServicesslotsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var slothight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var slotsCollection: UICollectionView!
    @IBOutlet weak var servicesLbl: UILabel!
    var delegate: ServicesslotsTableViewCellDelegate?
    var serviceId = 0
    var slots: [Slot] = []
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? SlotsDatum else { return }
        serviceId = model.serviceID ?? 0
        slotsCollection.skeleton()
        slotsCollection.delegate = self
        slotsCollection.dataSource = self
        slotsCollection.observe()
        slots.removeAll()
        slots.append(contentsOf: model.slots ?? [])
        servicesLbl.text = model.serviceName ?? ""
        if model.isselect ?? false {
            slotsCollection.isHidden = true
            slothight.constant = 0
            arrowImg.image = R.image.arrowdown()
        }else {
            arrowImg.image = R.image.arrowup()
            slotsCollection.isHidden = false
            let quotient = (model.slots?.count ?? 0) / 3
            let remainder = (model.slots?.count ?? 0) % 3
            slothight.constant = CGFloat((quotient + remainder) * 52)
        }
        slotsCollection.reloadData()
        arrowImg.UIViewAction {
            self.delegate?.selectservice(wasPressedOnCell: self, model: model)
        }
    }
    func reloadslots(id: String?) {
        var item = 0
        for index in slots {
            if index.from == id {
                slots[item].isselect = true
            }else {
                slots[item].isselect = false
            }
            item = item + 1
        }
        self.delegate?.selectslot(wasPressedOnCell: self, model: slots,serviceId: serviceId )
    }
}

extension ServicesslotsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = collectionViewWidth / 3 - 10
        return .init(width: itemWidth , height: 52)
       }
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return slots.count
          
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: SlotsCollectionViewCell.self, indexPath)
            cell.model = slots[safe: indexPath.row]
            cell.setup()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if slots[safe: indexPath.row]?.active ?? false == false {
            return
        }
        reloadslots(id: slots[safe: indexPath.row]?.from)
    }
   
  }
