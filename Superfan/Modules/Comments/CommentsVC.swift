//
//  CommentsVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CommentsVC: BaseController{
    @IBOutlet weak var sendBtn: UIButton!
    enum VerifyType {
        case add
        case edit
        case reply
    }
    @IBOutlet weak var commentsTbl: UITableView!
    @IBOutlet weak var commentTxf: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var CommentLbl: UILabel!
    var type: VerifyType = .add
    var viewModel: CommentsViewModel?
    var coordinator: CommentsCoordinator?
    var postId = 0
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(commentTxf, rules: [GuardRequired()], title: "Write what you think ...".localized).holdColor()
        return validator
    }()
    var isbackstage = false
}

// MARK: - ...  LifeCycle
extension CommentsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = true
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
        viewModel?.likedata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.likedata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
        })
        viewModel?.addcommentdata.listen(on: { [weak self] value in
            self?.commentTxf.text = ""
            if self?.viewModel?.type.value ?? "" == "reply" {
                self?.type = .reply
            }else {
                self?.type = .add
            }
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchcomments()
            self?.stopLoading()
        })
        viewModel?.deletedata.listen(on: { [weak self] value in
            self?.commentTxf.text = ""
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchcomments()
            self?.stopLoading()
        })
    }
    
    
}
    // MARK: - ...  Functions
    extension CommentsVC {
        func setup() {
            viewModel?.isbackstages.send(isbackstage)
            if type == .reply {
                viewModel?.type.send("reply")
            }
            commentsTbl.delegate = self
            commentsTbl.dataSource = self
            commentsTbl.observe()
            commentsTbl.skeleton()
            viewModel?.postId.send(postId)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchcomments()
            if UD.user != nil {
                userImg.setImage(url: UD.user?.data?.user?.photo ?? "")
            }else {
                userView.isHidden = true
                CommentLbl.isHidden = true
            }
//            commentTxf.returnPublisher.listen(on: {[weak self] _ in
//                self?.addcomment()
//            }).store(self)
            sendBtn.publisher.listen(on: {[weak self] _ in
                self?.addcomment()
            }).store(self)
           
        }
        func reload(){
            if viewModel?.items.value?.count ?? 0 == 0 {
                commentsTbl.isHidden = true
                showEmptyScreen(for: 400 , title: "There are no comments available".localized)
            }else {
                commentsTbl.isHidden = false
                hideEmptyScreen()
            }
            commentsTbl.reloadData()
            commentsTbl.stopSwipeButtom()
            
        }
        func addcomment(){
            if self.validator?.build() == false {
               
            }else {
                if commentTxf.isFirstResponder {
                    commentTxf.resignFirstResponder()
                }
                startLoading()
                viewModel?.comment.send(commentTxf.text ?? "")
                if type == .add || type == .reply {
                    viewModel?.addcomments()
                }else if type == .edit {
                    viewModel?.editomments()
                }
                commentTxf.resignFirstResponder()
            }
        }
        
    }
    // MARK: - ...  View Contract
    extension CommentsVC:UITableViewDelegate , UITableViewDataSource {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == commentsTbl {
                let tableViewVisibleHeight = commentsTbl.bounds.size.height
                   let tableViewContentHeight = commentsTbl.contentSize.height
                   let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
                   
                if scrollView.contentOffset.y > tableViewOffsetThreshold && commentsTbl.isDragging {
                    // Fetch more data here
                    if case self.viewModel?.canPaginate() = true {
                        self.viewModel?.fetchcomments()
                    }
                }
            }
        }
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if scrollView == commentsTbl {
                scrollView.swipeButtomRefresh { [weak self] in
                    if case self?.viewModel?.canPaginate() = true {
                        self?.viewModel?.fetchcomments()
                    } else {
                        scrollView.stopSwipeButtom()
                    }
                }
            }
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel?.dataSource()?.count ?? 2
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.cell(type: CommentsTableViewCell.self, indexPath)
            cell.model = viewModel?.dataSource()?[safe: indexPath.row]
            if type == .reply {
                cell.isreply = true
            }else {
                cell.isreply = false
            }
            cell.setup()
            cell.delegate = self
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if viewModel?.items.value?.count ?? 0 == 0 {
                return
            }
           
        }

    }
    extension CommentsVC : CommentsTableViewCellDelegate{
        func clubdetails(wasPressedOnCell cell: CommentsTableViewCell, clubId: Int) {
        }
        func favoraite(wasPressedOnCell cell: CommentsTableViewCell, model: CommentsDatum) {
            if UD.user == nil {
                Coordinator.instance.unAuthorized()
            }else {
                startLoading()
                viewModel?.commentId.send(model.id ?? 0)
                if model.isLiked == 1 {
                    viewModel?.unlikepost()
                }else {
                    viewModel?.likepost()
                }
            }
        }
        func comments(wasPressedOnCell cell: CommentsTableViewCell, model: CommentsDatum) {
            if UD.user == nil {
                Coordinator.instance.unAuthorized()
            }else {
                coordinator?.comments(id: model.id ?? 0)
            }
        }
        func edit(wasPressedOnCell cell: CommentsTableViewCell, model: CommentsDatum) {
            viewModel?.commentId.send(model.id ?? 0)
            commentTxf.text = model.comment ?? ""
            type = .edit
        }
        func delete(wasPressedOnCell cell: CommentsTableViewCell, model: CommentsDatum) {
            viewModel?.commentId.send(model.id ?? 0)
            if viewModel?.type.value ?? "" == "reply" {
                coordinator?.deletecomment(type1: 1)
            }else {
                coordinator?.deletecomment(type1: 0)
            }
        }
    }

