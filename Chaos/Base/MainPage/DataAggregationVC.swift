//
//  DataAggregationVC.swift
//  Chaos
//
//  Created by john on 2023/4/14.
//

import UIKit
import SnapKit

class DataAggregationVC: UIViewController {
    
    let addButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Add", for: .normal)
        return b
    }()
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
//        c.delegate = self
//        c.dataSource = self
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let c = NLLanguageRecognizer()
        setupLayout()
        setupEvents()
    }
    
    func setupLayout() {
        
        view.backgroundColor = .systemBackground
        
        [
            collectionView,
            addButton
        ].forEach({ view.addSubview($0) })
        
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupEvents() {
        let action = UIAction { [weak self] action in
            guard let self = self else { return }
            self.present(AddRecordVC(), animated: true)
        }
        addButton.addAction(action, for: .touchUpInside)
    }
}

extension DataAggregationVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
