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
    
    var movies: Results<MovieItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let movie = movieAtIndexPath(indexPath)
        cell.textLabel!.text = movie.title
        cell.imageView!.image = movie.image
        return cell
    }
    
    func loadData(){
        let realm = try! Realm()
        movies = realm.objects(MovieItem)
        favoritesTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "showFavoriteDetail":
                let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
                if let indexPath = self.favoritesTableView.indexPathForCell(sender as! UITableViewCell){
                    movieDetailsViewController.movie = movieAtIndexPath(indexPath)
                }
            default:break
            }
        }
    }
    
    func movieAtIndexPath(indexPath: NSIndexPath) -> Movie{
        let realmMovie = movies[indexPath.row]
        let movie = Movie()
        
        let url = NSURL(string: "http://image.tmdb.org/t/p/w185//" + realmMovie.imgPath!)
        let data = NSData(contentsOfURL: url!)
        movie.image = UIImage(data: data!)

        
        movie.id = realmMovie.id
        movie.tagline = realmMovie.tagline
        movie.title = realmMovie.title
        movie.voteAverage = realmMovie.voteAverage
        movie.overview = realmMovie.overview
        movie.releaseDate = realmMovie.releaseDate
        movie.posterPath = realmMovie.posterPath

        return movie
    }
}
