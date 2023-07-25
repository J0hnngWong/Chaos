//
//  InfinityListVC.swift
//  Chaos
//
//  Created by john on 2023/4/17.
//

import UIKit
import SnapKit

class InfinityListVC: UIViewController {
    
    let viewModel: InfinityListVM
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.delegate = self
        c.dataSource = self
        c.register(InfinityListCell.self, forCellWithReuseIdentifier: InfinityListCell.cellIdentifier())
        c.alwaysBounceVertical = true
        c.alwaysBounceHorizontal = false
        return c
    }()
    
    init(viewModel: InfinityListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupEvents()
    }
    
    func setupLayout() {
        
        navigationItem
            .rightBarButtonItem = .init(
                systemItem: .add,
                primaryAction: .init(handler: { [weak self] action in
                    guard let self = self else { return }
                    self.addNode()
                }))
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupEvents() {
        
    }
    
    func addNode() {
        let alert = UIAlertController(title: "New Node", message: "Enter Title", preferredStyle: .alert)
        var text: String?
        alert.addTextField { textField in
            textField.addAction(
                .init(
                    handler: { action in
                        text = (action.sender as? UITextField)?.text
                    }),
                for: .allEditingEvents)
        }
        alert.addAction(
            .init(
                title: "Confirm",
                style: .default,
                handler: { [weak self] action in
                    guard let self = self else { return }
                    self.viewModel.appendNode(node: .init(info: .init(title: text ?? "")))
                }))
        
        alert.addAction(
            .init(
                title: "Cancel",
                style: .cancel))
        present(alert, animated: true)
    }
}

extension InfinityListVC: InfinityListVMDelegate {
    func shouldRefresh() {
        collectionView.reloadData()
    }
}

extension InfinityListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: InfinityListCell.cellIdentifier(),
                    for: indexPath
                ) as? InfinityListCell
        else {
            fatalError()
        }
        let item = viewModel.item(indexPath: indexPath)
        cell.setup(node: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = viewModel.item(indexPath: indexPath)
        let vm = InfinityListVM(rootNode: item)
        let vc = InfinityListVC(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
