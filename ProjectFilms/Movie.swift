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
    var voteAverage: Double?
    var releaseDate: String?
    var imgPath: String?
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
                object.voteAverage = (anyObject[index]["vote_average"] as AnyObject? as? Double)
                object.releaseDate = (anyObject[index]["release_date"] as AnyObject? as? String)
                object.imgPath = (anyObject[index]["poster_path"] as AnyObject? as? String?)!
                let url = NSURL(string: "http://image.tmdb.org/t/p/w185//" + object.imgPath!)
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                object.image = UIImage(data: data!)
                list.append(object)
            }
        }
        return list
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL) -> UIImage{
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        var image = UIImage()
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                image = UIImage(data: data)!
            }
        }
        return image
    }
    
    static func parseJsonImage(anyObj : AnyObject) -> String{
        var imgpath = String()
        if anyObj is [AnyObject]{
            for var index = 0; index < anyObj.count ; ++index {
                //file_path
                let path = (anyObj[index]["file_path"] as AnyObject? as? String?)
                imgpath = path!!
            }
        }
        return imgpath
    }
}