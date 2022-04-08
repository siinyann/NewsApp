//
//  DetailsViewController.swift
//  newsApp
//
//  Created by Swift on 21/3/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var newsURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.isHidden = true
        msgLabel.isHidden = false;
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup after loading the view.
        if (newsURL != nil)
        {
            // If the newsURL is set by the first view controller then ask the webview to load and display that URL.
            let req = URLRequest(url: newsURL!)
            webView.loadRequest(req)
            
            webView.isHidden = false
            msgLabel.isHidden = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
