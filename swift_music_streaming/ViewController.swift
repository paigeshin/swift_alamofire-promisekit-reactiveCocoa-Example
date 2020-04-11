//
//  ViewController.swift
//  swift_music_streaming
//
//  Created by shin seunghyun on 2020/04/11.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var trackTable: TrackTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
    }
    
    func setUpSearchBar(){
        searchBar.reactive.searchButtonClicked.observeValues { [unowned self] in
            
            if var searchString = self.searchBar.text {
                searchString = searchString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if searchString.count > 0 {
                    //Constants에 있음.
                    self.callItuensApi(url: createSearchString(serachKeyword: searchString))
                }
                
            }
            
        }
    }
    
    func callItuensApi(url: String){
        let request = APIManager.api.fetchData(url: url)
        request.done {
            response in
            
            print(response)
            
            
            
        }
    }

}

