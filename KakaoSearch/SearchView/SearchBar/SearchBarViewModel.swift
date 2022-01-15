//
//  SearchBarViewModel.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchBarViewModel {
    //view -> viewModel
    let searchQuery = PublishRelay<String?>()
    var searchButtonTapped = PublishRelay<Void>()
    
    //viewModel -> view
    var inputSearchQuery: Observable<String>
    
    init() {
        inputSearchQuery = searchButtonTapped
            .withLatestFrom(searchQuery) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
