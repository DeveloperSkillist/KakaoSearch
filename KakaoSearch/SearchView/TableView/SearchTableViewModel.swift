//
//  SearchTableViewModel.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchTableViewModel {
    
    //view -> ViewModel
    var imageResults = PublishRelay<[SearchImageResult]>()
    
    //viewModel -> view
    var items: Driver<[SearchImageResult]>
    
    init() {
        items = imageResults
            .asDriver(onErrorJustReturn: [])
    }
}
