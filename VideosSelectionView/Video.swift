//
//  Video.swift
//  VideosSelectionView
//
//  Created by Anthony Ma on 10/9/2016.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var imageData: Data?
        
    var image: UIImage?
    
    var songName: String?
    
    var videoId: String?
    
    override init() {
        
        self.imageData = nil
        self.image = nil
        self.songName = ""
        self.videoId = ""
        
    }

}
