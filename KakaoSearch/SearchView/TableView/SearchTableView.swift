//
//  SearchTableView.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchTableView: UITableView {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchTableViewModel) {
        viewModel.items
            .drive(self.rx.items) { tableView, row, data in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchImageCell", for: IndexPath(row: row, section: 0)) as? SearchImageCell else {
                    return UITableViewCell()
                }
                cell.setData(imageResult: data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.register(SearchImageCell.self, forCellReuseIdentifier: "SearchImageCell")
        self.rowHeight = 100
        self.separatorStyle = .singleLine
    }
}
