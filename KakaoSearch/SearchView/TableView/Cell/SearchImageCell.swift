//
//  SearchImageCell.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import UIKit
import Kingfisher

class SearchImageCell: UITableViewCell {
    private var searchImageView = UIImageView()
    private var titleLabel = UILabel()
    private var dateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            searchImageView,
            titleLabel,
            dateLabel
        ].forEach {
            addSubview($0)
        }
        
        searchImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(searchImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchImageView)
            $0.leading.equalTo(searchImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(searchImageView)
        }
    }
    
    func setData(imageResult: SearchImageResult) {
        searchImageView.kf.setImage(with: URL(string: imageResult.thumbnailURL), placeholder: UIImage(systemName: "photo"))
        titleLabel.text = imageResult.displaySitename
        dateLabel.text = imageResult.datetime
    }
}
