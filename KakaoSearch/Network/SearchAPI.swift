//
//  SearchBlogAPI.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import Foundation

struct SearchBlogAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/search/"
    
    private func searchComponents(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = SearchBlogAPI.scheme
        components.host = SearchBlogAPI.host
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        return components
    }
    
    func searchImage(query: String) -> URLComponents {
        var urlComponents = searchComponents(query: query)
        urlComponents.path = SearchBlogAPI.path + "image"
        return urlComponents
    }
}
