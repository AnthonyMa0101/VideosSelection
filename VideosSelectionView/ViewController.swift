//
//  ViewController.swift
//  VideosSelectionView
//
//  Created by Anthony Ma on 8/9/2016.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView?
    
    var backgroundImage: UIImageView?
    
    let layout: UICollectionViewLayout = VideoSelectedLayout()
    
    let reuseIdentifier = "cell"
    
    var videos: [Video] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        
        self.collectionView?.delegate = self
        
        self.collectionView?.dataSource = self
        
        self.collectionView?.register(Cells.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.backgroundColor = UIColor.clear
        
//        self.backgroundImage = UIImageView.init(frame: self.view.bounds)
//        self.backgroundImage?.backgroundColor = UIColor.clear
//        self.backgroundImage!.image = UIImage.init(named: "white-texture.jpg")
        
        APIObject.sharedInstance.getVideos { (userVideos: [Video]) in
            
            self.videos = userVideos
            
            self.collectionView?.reloadData()
        }
        
//        self.view.addSubview(self.backgroundImage!)
        self.view.addSubview(self.collectionView!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.clear
        
        self.collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//            APIObject.sharedInstance.getVideos { (userVideos: [Video]) in
//                
//                self.videos = userVideos
//                
//                self.collectionView!.reloadData()
//            }
//    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cells
        
        let video = self.videos[indexPath.item]
        
        print(self.videos[indexPath.item])
        
        cell.video = video
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

