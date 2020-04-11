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
