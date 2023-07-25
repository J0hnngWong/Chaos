//
//  InfinityListCell.swift
//  Chaos
//
//  Created by john on 2023/4/17.
//

import UIKit
import SnapKit

class InfinityListCell: UICollectionViewCell, IdentifiableCell {
    let label: UILabel = {
        let l = UILabel(frame: .zero)
        l.textColor = .label
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func setup(node: InfinityListNode) {
        label.text = node.info.title
    }
}
