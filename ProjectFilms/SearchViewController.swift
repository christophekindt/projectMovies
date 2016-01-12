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
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let movie = self.movies[indexPath.row]
        cell.textLabel!.text = movie.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let movie = self.movies[indexPath.row]
        performSegueWithIdentifier("showDetailSearch", sender: tableView.cellForRowAtIndexPath(indexPath))
        print(movie.title)
    }
    
    func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchString searchString: String?)  -> Bool {
        
        _loadMovies(searchDisplayController!.searchBar.text!)
        
        return true
    }
    
    func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        let query = searchDisplayController!.searchBar.text

        _loadMovies(query!)
        return true
    }
    
    func _loadMovies(query: String){
        let queryFinal = query.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        MovieService.sharedInstance.fetchSearchMovies(queryFinal,completion: {
            (error, data) -> () in
            if let json_data = data?["results"] {
                if json_data != nil{
                    self.movies = MovieHandler.parseJSon(json_data!)
                    dispatch_async(dispatch_get_main_queue(), {
                        () -> Void in
                        self.tableView.reloadData()
                    })

                }
            }
        })
    }
    
    func movieAtIndexPath(indexPath: NSIndexPath) -> Movie{
        let movie = movies[indexPath.row]
        return movie
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "showDetailSearch":
                let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
                if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell){
                    movieDetailsViewController.movie = movieAtIndexPath(indexPath)
                }
                
            default:break
            }
        }
    }

}
