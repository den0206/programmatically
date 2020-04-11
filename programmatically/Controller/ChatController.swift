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
    
    //MARK: - Parts
    private lazy var customInputView : CustomInputAccesaryView = {
        let iv = CustomInputAccesaryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
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

    }
}

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        
        return cell
    }
}


extension ChatController : UICollectionViewDelegateFlowLayout {
    /// padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return.init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }
}

