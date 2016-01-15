//
//  SearchViewController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 09/01/16.
//  Copyright © 2016 Christophe Kindt. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController{
    
    @IBOutlet var searchTableView: UITableView!
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let movie = self.movies[indexPath.row]
        cell.textLabel!.text = movie.title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.tableView.reloadData()
        let movie = self.movies[indexPath.row]
        print(movie.title)
        //performSegueWithIdentifier("showDetailSearch", sender: self)
    }
    
    func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchString searchString: String?)  -> Bool {
        self.tableView.reloadData()
        _loadMovies(searchDisplayController!.searchBar.text!)
        _loadMovies(searchString!)
        return true
    }
    
    func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.tableView.reloadData()
        let query = searchDisplayController!.searchBar.text
        _loadMovies(query!)
        return true
    }
    
    func _loadMovies(query: String){
        let queryFinal = query.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        MovieService.sharedInstance.fetchSearchMovies(queryFinal,completion: {
            (error, data) -> () in
            if let json_data = (data?["results"] as AnyObject?) {
                    self.movies = MovieHandler.parseJSon(json_data)
                    dispatch_async(dispatch_get_main_queue(), {
                        () -> Void in
                    })
            }
        })
    }
    
    func movieAtIndexPath(indexPath: NSIndexPath) -> Movie{
        searchTableView.reloadData()
        let movie = movies[indexPath.row]
        return movie
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //self.searchDisplayController?.searchBar.text = nil
        if let identifier = segue.identifier{
            switch identifier{
            case "showDetailSearch":
                //print(sender.self)
                let movieDetailsVC = segue.destinationViewController as! MovieDetailsViewController
                let cell = sender as! UITableViewCell
                if let indexPath = self.searchTableView.indexPathForRowAtPoint(cell.center){
                    movieDetailsVC.movie = movieAtIndexPath(indexPath)
                }
                
            default:break
            }
        }
    }

}
