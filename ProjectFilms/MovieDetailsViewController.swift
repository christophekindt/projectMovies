//
//  MovieDetailsViewController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 08/12/15.
//  Copyright © 2015 Christophe Kindt. All rights reserved.
//

import UIKit
import RealmSwift

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releasedateLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.path!)
        titleLabel.text = movie?.title
        //ratingStars.rating = (movie?.voteAverage)!
        ratingStars.settings.fillMode = .Precise
        ratingStars.settings.updateOnTouch = false
        overviewText.text = movie?.overview
        releasedateLabel.text = movie?.releaseDate
        posterImage.image = movie?.image
        
    }
    
    @IBAction func addFavoriteMovieButtonPressed(sender: AnyObject) {
        
        if saveMovie(){
            //Source: http://www.ioscreator.com/tutorials/display-an-alert-view-in-ios8-with-swift
            let alertController = UIAlertController(title: "Movie added", message: "The movie was succesfully added to your favorites.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title:"Dismiss",style: UIAlertActionStyle.Default, handler:nil))
            self.presentViewController(alertController,animated: true, completion:nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
        } else{
            //Source: http://www.ioscreator.com/tutorials/display-an-alert-view-in-ios8-with-swift
            let alertController = UIAlertController(title: "Movie already in favorites", message: "The movie is already in your favorites list.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title:"Dismiss",style: UIAlertActionStyle.Default, handler:nil))
            self.presentViewController(alertController,animated: true, completion:nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveMovie() -> Bool{
        let realm = try! Realm()
        let movies = realm.objects(MovieItem)
        var result = false
        print(movies)
        
        for currentMovie in movies{
            if (currentMovie.id == movie!.id){
                return result
            }
        }
        
        let newMovie = MovieItem()
        newMovie.id = movie?.id
        newMovie.tagline = movie?.tagline
        newMovie.title = movie?.title
        newMovie.voteAverage = movie?.voteAverage
        newMovie.overview = movie?.overview
        newMovie.releaseDate = movie?.releaseDate
        newMovie.imgPath = movie?.imgPath
        
        try! realm.write {
            realm.add(newMovie)
        }
        result = true
        return result
    }
}
