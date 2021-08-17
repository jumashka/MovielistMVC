//
//  MovieModel.swift
//  MovieDB
//
//  Created by Juma on 8/12/21.
//

import UIKit

struct MovieModel: Codable {
    var results:[Results]? 
}

struct Results: Codable {
    var backdrop_path   : String?
    var title           : String?
    var popularity      : Double?
    var release_date    : String?
}
