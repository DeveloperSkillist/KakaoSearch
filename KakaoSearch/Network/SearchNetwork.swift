//
//  SearchNetwork.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}
class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchImage(query: String) -> Single<Result<SearchImageResults, SearchNetworkError>> {  //success와 error을 출력한다.
        guard let url = api.searchImage(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK \(APIKeys.kakaoRestAPIKey)", forHTTPHeaderField: "Authorization")
    
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let searchData = try JSONDecoder().decode(SearchImageResults.self, from: data)
                    print("nerwork : success")
                    return .success(searchData)
                } catch {
                    print("nerwork : invalidJSON")
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
//                print("nerwork : networkError")
                .just(.failure(.networkError))
            }
            .asSingle()
    }
}
