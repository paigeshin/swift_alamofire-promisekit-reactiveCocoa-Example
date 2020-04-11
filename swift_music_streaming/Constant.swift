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
