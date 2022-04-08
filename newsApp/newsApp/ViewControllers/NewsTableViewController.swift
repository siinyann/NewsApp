//
//  NewsTableViewController.swift
//  newsApp
//
//  Created by Swift on 21/3/22.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var newsList : [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeed("iphone")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    // One of the functions for UITableViewDataSource.
    // Tells the table view how many section there are.
    // In our case, there's only 1 section.
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // One of the functions for UITableViewDataSource.
    // Tells the table view how many items in the given section.
    // Since we  have only 1 section, this function will only be called once by the tableView where the section = 1.
    // So we just return the number of items in the newsList array.
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsList.count
    }

    // One of the functions for UITableViewDataSource.
    // Creates or reuses a UITableviewCell with the data at the row position and returns it.
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let news = newsList[indexPath.row]
        cell.textLabel!.text = news.title

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the news at the selected row.
        let selectedNews = newsList[indexPath.row]
        
        // We load an instance of the view controller from the storyboard with the id "idDetailsViewController"
        //
        let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idDetailsViewController") as! DetailsViewController
        
        // Set the newsURL.
        detailsViewController.newsURL = URL(string: selectedNews.url)
        
        // Show the view controller of the detail screen.
        self.showDetailViewController(detailsViewController, sender: self)
    }
    
    func loadFeed(_ subreddit: String)
    {
        // Queue an asynchronous task on the background thread, so that viewDidLoad will end immediately, while the task programmed inside the dispatch will run at a later time.
        //
        NewsDataManager.loadNews(subreddit: subreddit, onComplete:
            {
                (newsListDownloadedFromReddit) in
                
                // set the news list downloaded from Reddit to our own newsList variable.
                //
                self.newsList = newsListDownloadedFromReddit
            
                DispatchQueue.main.async
                {
                    // Tells the tableView to refresh itself.
                    //
                    // Since we are updating the user interface, we use DispatchQueue.main.async to instruct iOS to call reloadData in the main worker thread.
                    //
                    self.tableView.reloadData()
                }
        })
    }
}
