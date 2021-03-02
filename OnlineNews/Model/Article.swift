//
//  Article.swift
//  OnlineNews
//
//  Created by Maria Kramer on 26.02.2021.
//

import Foundation

struct Article : Decodable {
 
    var autor:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt: String?
    
 
}
