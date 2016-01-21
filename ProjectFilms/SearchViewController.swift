//
//  SearchViewController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 09/01/16.
//  Copyright © 2016 Christophe Kindt. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchResultsUpdating{
    
    @IBOutlet var searchTableView: UITableView!
    var movies:[Movie] = [Movie](){
        didSet {self.searchTableView.reloadData()}
    }
    let movieSearchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        movieSearchController.searchResultsUpdater = self
        movieSearchController.hidesNavigationBarDuringPresentation = false
        movieSearchController.dimsBackgroundDuringPresentation = false
        movieSearchController.searchBar.sizeToFit()
        self.searchTableView.tableHeaderView = movieSearchController.searchBar
        
        self.searchTableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(movieSearchController: UISearchController) {
        movies.removeAll(keepCapacity: false)
        
        _loadMovies(movieSearchController.searchBar.text!)
        
        self.searchTableView.reloadData()
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
    /*override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.searchTableView.reloadData()
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.tableView.reloadData()
        let movie = self.movies[indexPath.row]
        print(movie.title)
    }
    
    func _loadMovies(query: String){
        let queryFinal = query.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        MovieService.sharedInstance.fetchSearchMovies(queryFinal,completion: {
            (error, data) -> () in
            if let json_data = (data?["results"] as AnyObject?) {
                    self.movies = MovieHandler.parseJSon(json_data)
                    dispatch_async(dispatch_get_main_queue(), {
                        () -> Void in
                        self.searchTableView.reloadData()
                    })
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
