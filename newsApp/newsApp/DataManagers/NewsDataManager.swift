//
//  NewsDataManager.swift
//  newsApp
//
//  Created by Swift on 21/3/22.
//

import Foundation

class NewsDataManager
{
    class func loadNews (
        subreddit: String,
        onComplete: (( _ : [News]) -> Void)?)
    {
        let q = subreddit.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://api.reddit.com/r/\(q)/new"
        
        // Queue an asynchronous task on the background thread, so that viewDidLoad will end immediately, while the task programmed inside the dispatch will run at a later time.
        //
        HTTP.getJSON(url: url, onComplete:
        {
            (json, reponse, error) in
            
            if error != nil
            {
                return
            }
            
            let articles = json!
            
            // Get the total number of articles loaded from the JSON API
            //
            let count = articles["data"]["children"].count
            
            // Clear all the news from our list first.
            //
            var newsList : [News] = []
            
            // Loop through each article, create a new News object for each article and add it to our list.
            //
            for i in 0 ..< count
            {
                let article = articles["data"]["children"][i]
                
                let news = News(
                    title: article["data"]["title"].string!,
                    url: article["data"]["url"].string!)
                
                newsList.append(news)
            }
            
            // Now we call the caller's onComplete method so that the caller can process the data or display it on the screen
            //
            onComplete?(newsList)
        })
    }
}
