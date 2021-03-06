//
//  TopMoviesViewControllerTableViewController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 08/12/15.
//  Copyright © 2015 Christophe Kindt. All rights reserved.
//

import UIKit

class TopMoviesViewControllerTableViewController: UITableViewController {
    private var movies = [Movie]()
    private var imageString = String()
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        _loadMovies()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func _loadMovies(){
        MovieService.sharedInstance.fetchTopMovies({
            (error, data) -> () in
            if let json_data = (data?["results"] as AnyObject?) {
                //print(MovieHandler.parseJSon(json_data!))
                self.movies = MovieHandler.parseJSon(json_data)
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    //do something with the things you've received from the api
                    self.tableView.reloadData()
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel!.text = movie.title
        cell.imageView!.image = movie.image
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "showMovieDetail":
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

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
