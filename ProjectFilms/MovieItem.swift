//
//  MovieItem.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 15/01/16.
//  Copyright © 2016 Christophe Kindt. All rights reserved.
//

import RealmSwift

class MovieItem: Object {
    var id : Int?
    dynamic var title : String?
    dynamic var overview: String?
    dynamic var tagline : String?
    dynamic var posterPath: String?
    dynamic var voteAverage: Double = 0.0
    dynamic var releaseDate: String?
    dynamic var imgPath: String?
}
