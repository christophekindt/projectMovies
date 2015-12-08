//
//  Movie.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 08/12/15.
//  Copyright © 2015 Christophe Kindt. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    var id : Int?
    var title : String?
    var overview: String?
    var tagline : String?
    var posterPath: String?
    var image: UIImage?
}

class MovieHandler {
    static func parseJSon(anyObject : AnyObject) -> [Movie] {
        var list = [Movie]()
        if anyObject is [AnyObject]{
            for var index = 0; index < anyObject.count; ++index
            {
                var object = Movie()
                object.id = (anyObject[index]["id"] as AnyObject? as? Int)
                object.title = (anyObject[index]["original_title"] as AnyObject? as? String)
                object.overview = (anyObject[index]["overview"] as AnyObject? as? String)
                object.tagline = (anyObject[index]["tagline"] as AnyObject? as? String)
                object.posterPath = (anyObject[index]["poster_path"] as AnyObject? as? String)
                print(object.title)
                list.append(object)
            }
        }
        return list
    }
    
    static func parseJsonImage(anyObj : AnyObject) -> [String]{
        var list = [String]()
        if anyObj is [AnyObject]{
            for var index = 0; index < anyObj.count ; ++index {
                //file_path
                let path = (anyObj[index]["file_path"] as AnyObject? as? String?)
                list.append(path!!)
            }
        }
        return list
    }
}