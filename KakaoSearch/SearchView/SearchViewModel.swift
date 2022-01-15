//
//  SearchViewModel.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation
import RxSwift
import RxRelay

struct SearchViewModel {
    let disposeBag = DisposeBag()
    let searchBarViewModel = SearchBarViewModel()
    let searchTableViewModel = SearchTableViewModel()
    
    //view -> viewModel
    let cellSelected = PublishRelay<SearchImageResult>()
    
    init() {
        searchBarViewModel.inputSearchQuery
            .flatMapLatest { query in
                SearchBlogNetwork().searchImage(query: query)
            }
            .compactMap { data -> [SearchImageResult]? in
                guard case .success(let value) = data else {
                    return nil
                }
                return value.imageResults
            }
            .bind(to: searchTableViewModel.imageResults)
            .disposed(by: disposeBag)
        
        cellSelected
            .subscribe(onNext: { data in
                print("selected \(data.thumbnailURL)")
            })
            .disposed(by: disposeBag)
//        let searchResult = searchBarViewModel.inputSearchQuery
//            .flatMapLatest { query in
//                SearchBlogNetwork().searchImage(query: query)
//            }
//            .share()
//
//        let imageSearchResults = searchResult
//            .compactMap { data -> [SearchImageResult]? in
//                guard case .success(let value) = data else {
//                    return nil
//                }
//                return value.imageResults
//            }
//            .bind(to: searchTableViewModel.imageResults)
//            .disposed(by: disposeBag)
//
//        let imageSearchError = searchResult
//            .compactMap { data -> String? in
//                guard case .failure(let error) = data else {
//                    return nil
//                }
//                return error.localizedDescription
//            }
    }
}
