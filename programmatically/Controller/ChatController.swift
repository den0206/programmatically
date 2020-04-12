//
//  ChatController.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
private let reuseIdentifier = "ChatCell"

class ChatController : UICollectionViewController {
    
    private let user : User
    var fromCurrentUser = false
    
    private var messages = [Message]() {
        didSet {
            collectionView.reloadData()
        }
    }
    //MARK: - Parts
    private lazy var customInputView : CustomInputAccesaryView = {
        let iv = CustomInputAccesaryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        iv.delegate = self
        return iv
    }()
    
    
    init(user : User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchMessages()
        
    }
    
    
    /// set custom inputView
    override var inputAccessoryView: UIView? {
        get {return customInputView}
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private func configureUI() {
        collectionView.backgroundColor = .white
        configureNav(title: user.username, preferLargeTitle: false)
        
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        
        collectionView.keyboardDismissMode = .interactive

    }
    
    //MARK: - API
    
    func fetchMessages() {
        Service.fetchMessage(forUser: user) { (messages) in
            self.messages = messages
            
            /// Scroll To Bottom
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
    }
}

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        
        cell.message = messages[indexPath.item]
        /// no Good
        cell.message?.user = user
        return cell
    }
}


extension ChatController : UICollectionViewDelegateFlowLayout {
    /// padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return.init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedSizeCell = ChatCell(frame: frame)
        estimatedSizeCell.message = messages[indexPath.item]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

//MARK: - CustomInputView Delegate
extension ChatController : CustomInputAccesaryViewDelegate {
    func inputView(_ inputview: CustomInputAccesaryView, message: String) {

//        fromCurrentUser.toggle()
//        let message = Message(text: message, isFromCurrentUser: fromCurrentUser)
//        messages.append(message)
        
        Service.uploadMessage(message, toUser: user) { (error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            inputview.clearMessageText()
 
        }
    }
    
    
}

