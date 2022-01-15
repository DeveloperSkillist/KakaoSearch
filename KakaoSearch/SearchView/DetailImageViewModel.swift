//
//  DetailImageViewModel.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailImageViewModel {
    
    //view -> viewModel
    let searchImageResult = PublishRelay<SearchImageResult>()
    
    //viewModel -> view
    
    init(searchImageResult: SearchImageResult) {
//        self.searchImageResult = searchImageResult
//
//        let searchImageResult = self.searchImageResult
    }
}
