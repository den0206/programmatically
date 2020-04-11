//
//  ChatController.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

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

    }
}


