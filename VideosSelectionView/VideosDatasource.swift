//
//  VideosDatasource.swift
//  VideosSelectionView
//
//  Created by Anthony Ma on 8/9/2016.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

import UIKit

/*
class VideosDatasource: NSObject, UICollectionViewDataSource {
    
    var videos: [Video] = []

    func getVideos() -> [Video] {
        APIObject.sharedInstance.getVideos { (userVideos: [Video]) in
            self.videos = userVideos
            print(self.videos)
            ViewController().collectionView!.reloadData()
        }
        return self.videos
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        self.getVideos()
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Cells
        
        let video = self.videos[indexPath.item]
        
        cell.video = video
        
        return cell
    }
    
}
 
*/
