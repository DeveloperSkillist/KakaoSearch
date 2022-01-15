//
//  SearchBar.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        self.rx.text
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)
        
        Observable
            .merge(
                searchButton.rx.tap.asObservable(),
                self.rx.searchButtonClicked.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
            
        viewModel.searchButtonTapped
            .bind(to: self.rx.endEditing)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.link, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(12)
        }
        
        searchButton.snp.makeConstraints {
            $0.leading.equalTo(searchTextField.snp.trailing).offset(8)
            $0.top.bottom.equalTo(searchTextField)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
