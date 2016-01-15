//
//  FavoriteMoviesController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 15/01/16.
//  Copyright © 2016 Christophe Kindt. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteMoviesController: UITableViewController {
    @IBOutlet var favoritesTableView: UITableView!
    
    var movies: Results<Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel!.text = movie.title
        cell.imageView!.image = movie.image
        return cell
    }
    
    func loadData(){
        let realm = try! Realm()
        movies = realm.objects(Movie)
        favoritesTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "showFavoriteDetail":
                let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
                if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell){
                    movieDetailsViewController.movie = movieAtIndexPath(indexPath)
                }
            default:break
            }
        }
    }
    
    func movieAtIndexPath(indexPath: NSIndexPath) -> Movie{
        let movie = movies[indexPath.row]
        return movie
    }
}
