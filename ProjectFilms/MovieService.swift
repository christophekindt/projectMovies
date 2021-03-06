//
//  MovieService.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 08/12/15.
//  Copyright © 2015 Christophe Kindt. All rights reserved.
//

import Foundation
import UIKit

private let _SharedInstance = MovieService()

class MovieService : NSObject {
    
    class var sharedInstance : MovieService {
        return _SharedInstance
    }
    
    private override init(){
        configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        super.init()
    }
    
    private var configuration: NSURLSessionConfiguration
    private var session : NSURLSession?
    
    private let baseURL: String = "http://api.themoviedb.org/3/"
    
    func fetchTopMovies(completion: (error: NSError?, data: AnyObject?) ->()) {
        let urlString = baseURL + "movie/popular?api_key=5196faf79431bbd9add89180c09cbc2f"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        session = NSURLSession(configuration: configuration)
        
        let task = session!.dataTaskWithRequest(request,completionHandler: {
            (data, response, error) -> Void in
            do {
                if let data = data, let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) {
                    completion(error: nil, data: json!)
                } else {
                    completion(error: error, data: nil)
                }
            } catch {
                print("Something went wrong")
            }
        })
        task.resume()
    }
    func fetchSearchMovies(query: String, completion: (error: NSError?, data: AnyObject?) ->()) {
        let urlString = baseURL + "search/movie?api_key=5196faf79431bbd9add89180c09cbc2f&query=" + query
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        session = NSURLSession(configuration: configuration)
        
        let task = session!.dataTaskWithRequest(request,completionHandler: {
            (data, response, error) -> Void in
            do {
                if let data = data, let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) {
                    completion(error: nil, data: json!)
                } else {
                    completion(error: error, data: nil)
                }
            } catch {
                print("Something went wrong")
            }
        })
        task.resume()
    }

}