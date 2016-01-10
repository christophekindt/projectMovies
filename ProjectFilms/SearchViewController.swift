//
//  SearchViewController.swift
//  ProjectFilms
//
//  Created by Christophe Kindt on 09/01/16.
//  Copyright © 2016 Christophe Kindt. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    @IBOutlet var searchTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.searchDisplayController?.searchResultsTableView){
            return 1
        } else{
            return 0
        }
    }
    
    
    
    
    
}
