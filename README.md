# swift_alamofire-promisekit-reactiveCocoa-Example

# 🔷 1차 버전

# Dependency

    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'PromiseKit'
    pod 'SkeletonView'
    pod 'ReactiveCocoa', '~> 10.1'

# View Controller

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
                
                
                
                
            }
        }
    
    }

- reactive programming

# APIManager.swift

    //
    //  APIManager.swift
    //  swift_music_streaming
    //
    //  Created by shin seunghyun on 2020/04/11.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import Foundation
    import Alamofire
    import PromiseKit
    
    class APIManager {
        
        static let api = APIManager()
        
        private init() {
            
        }
        
        func fetchData(url: String) -> Promise<[String]> {
            
            return Promise {
                resolver in
                
                AF.request(BASE_URL).responseString {
                    response in
                    
                    switch(response.result) {
                        
                    case .success(let data):
                        resolver.fulfill([""])
                        print("my actual response in :-", data)
                    case .failure(let error):
                        resolver.reject(error)
                        print(error)
                        
                    }
                    
                }
            }
            
        }
        
    }

- singleton
- alamofire
- promise

# TrackTable

    //
    //  TrackTable.swift
    //  swift_music_streaming
    //
    //  Created by shin seunghyun on 2020/04/11.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    
    //이런 식으로 custom tableView를 custom 하는 것도 가능
    class TrackTable: UITableView, UITableViewDataSource, UITableViewDelegate {
    
        var dataSourceArray = [Track]() {
            didSet {
                reloadData()
            }
        }
        
        override func awakeFromNib() {
            self.delegate = self
            self.dataSource = self
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataSourceArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackCell
            cell.populateCell(track: dataSourceArray[indexPath.row])
            return cell
        }
    
    }

- custom tableview ⇒ 소스 분리에 유리

# TrackCell

    //
    //  TrackCell.swift
    //  swift_music_streaming
    //
    //  Created by shin seunghyun on 2020/04/11.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import AlamofireImage
    
    class TrackCell: UITableViewCell {
        
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var songView: UIView!
        @IBOutlet weak var name: UILabel!
        @IBOutlet weak var genre: UILabel!
        @IBOutlet weak var artist: UILabel!
        @IBOutlet weak var trackImage: UIImageView!
        
        
        override func awakeFromNib() {
            super.awakeFromNib()
            trackImage.clipsToBounds = true
            selectionStyle = .none
        }
        
        func populateCell(track: Track) {
            name.text = track.trackName
            artist.text = track.artistName
            genre.text = track.primaryGenreName
            
            if let url = track.artWorkUrl100 {
                trackImage.af_setImage(withURL: url)
            }
        }
        
    }

- alamofire image

# Track

    //
    //  DataModel.swift
    //  swift_music_streaming
    //
    //  Created by shin seunghyun on 2020/04/11.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import Foundation
    
    class Track: Decodable {
        
        var trackName: String
        var artistName: String
        var primaryGenreName: String
        var previewUrl: URL?
        var artWorkUrl100: URL?
        var collectionName: String?
        var trackTimeMillis: Int
        
    }

# Constant

    //
    //  Constant.swift
    //  swift_music_streaming
    //
    //  Created by shin seunghyun on 2020/04/11.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import Foundation
    
    let BASE_URL = "https://itunes.apple.com/search?"
    
    func createSearchString(serachKeyword: String) -> String {
        
        //encoding
        let searchString = serachKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlString = "term=\(searchString!)&media=music&entity=musicTrack"
        
        return BASE_URL + urlString
    }
