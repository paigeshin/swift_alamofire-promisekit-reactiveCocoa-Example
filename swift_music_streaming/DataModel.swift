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
