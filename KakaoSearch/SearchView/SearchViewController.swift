//
//  SearchViewController.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchViewController: UIViewController {
    let disposeBag = DisposeBag()
    let searchBar = SearchBar()
    let tableView = SearchTableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchViewModel) {
        searchBar.bind(viewModel.searchBarViewModel)
        tableView.bind(viewModel.searchTableViewModel)
        
        tableView.rx.modelSelected(SearchImageResult.self)
            .subscribe(onNext: { _ in
                let detailVC = DetailImageView()
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "Search Image"
        view.backgroundColor = .white
    }
    
    private func layout() {
        [
            searchBar,
            tableView
        ].forEach {
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
