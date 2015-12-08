//
//  MovieService.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 08/12/15.
//  Copyright © 2015 Christophe Kindt. All rights reserved.
//

import Foundation
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
    
    func fetch(completion: (error: NSError?, data: AnyObject?) ->()) {
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
    
    
    func fetchImageFromMovie(movieID: Int, completion: (error : NSError?, data: AnyObject?) ->()){
        
        let urlString = baseURL + "movie/\(movieID)/images?api_key=58307881d9d420ad0d98ae233a8f249a"
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