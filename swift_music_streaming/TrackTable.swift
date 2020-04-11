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
