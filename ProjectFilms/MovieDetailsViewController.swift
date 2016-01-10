//
//  MovieDetailsViewController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 08/12/15.
//  Copyright © 2015 Christophe Kindt. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releasedateLabel: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie?.title
        ratingStars.rating = (movie?.voteAverage)!
        ratingStars.settings.fillMode = .Precise
        ratingStars.settings.updateOnTouch = false
        overviewText.text = movie?.overview
        releasedateLabel.text = movie?.releaseDate
        posterImage.image = movie?.image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
