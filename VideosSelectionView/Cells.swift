//
//  Cells.swift
//  VideosSelectionView
//
//  Created by Anthony Ma on 10/9/2016.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

import UIKit

class Cells: UICollectionViewCell {
    
    let vinylImage = UIImage.init(named: "Vinyl.jpeg")
    
    var imageView: UIImageView?
    
    var imageCoverView: UIView?
    
    var backgroundImage: UIImageView?
    
    var songName: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.darkGray
        
//        backgroundImage = UIImageView.init(frame: contentView.frame)
//        backgroundImage?.translatesAutoresizingMaskIntoConstraints = false
        
        imageCoverView = UIView.init(frame: contentView.frame)
        imageCoverView?.backgroundColor = UIColor.gray
        imageCoverView?.translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView.init()
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        songName = UILabel.init()
        songName?.textColor = UIColor.white
        songName?.font = UIFont.init(name: "MarkerFelt-Wide", size: 30.0)
        songName?.textAlignment = .left
        songName?.lineBreakMode = .byWordWrapping
        songName?.numberOfLines = 0
        songName?.backgroundColor = UIColor.clear
        songName?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageCoverView!)
//        imageCoverView!.addSubview(backgroundImage!)
        contentView.addSubview(imageView!)
        contentView.addSubview(songName!)
        
        contentView.bringSubview(toFront: imageCoverView!)
        
        //MARK: cover view constraints
        
        let imageCoverViewLeftConstraint = NSLayoutConstraint.init(item: imageCoverView!, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0)
        
        let imageCoverViewTopConstraint = NSLayoutConstraint.init(item: imageCoverView!, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        
        let imageCoverViewHeightConstraint = NSLayoutConstraint.init(item: imageCoverView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 280)
        
        let imageCoverViewWidth = NSLayoutConstraint.init(item: imageCoverView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.width)
        
        contentView.addConstraints([imageCoverViewLeftConstraint, imageCoverViewTopConstraint, imageCoverViewHeightConstraint, imageCoverViewWidth])
        
        //MARK: background constraints
        
//        let backgroundLeading = NSLayoutConstraint.init(item: backgroundImage!, attribute: .centerX , relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0)
//
//        let backgroundTop = NSLayoutConstraint.init(item: backgroundImage!, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0)
//
//        let backgroundheight = NSLayoutConstraint.init(item: backgroundImage!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 280)
//
//        let backgroundWidth = NSLayoutConstraint.init(item: backgroundImage!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.width)
//
//        contentView.addConstraints([backgroundLeading, backgroundTop, backgroundheight])
        
        //MARK: image view constraints
        
        let imageViewVerticalY = NSLayoutConstraint.init(item: imageView!, attribute: .centerX, relatedBy: .equal, toItem: imageCoverView!, attribute: .centerX, multiplier: 1.0, constant: 0)
        
        let imageViewVerticalX = NSLayoutConstraint.init(item: imageView!, attribute: .centerY, relatedBy: .equal, toItem: imageCoverView!, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        let imageViewHeight = NSLayoutConstraint.init(item: imageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.height)
        
        let imageViewWidth = NSLayoutConstraint.init(item: imageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.width)
        
        contentView.addConstraints([imageViewVerticalX, imageViewVerticalY, imageViewHeight, imageViewWidth])
        
        //MARK: song name constraints
        
        let labelCenterX = NSLayoutConstraint.init(item: songName!, attribute: .leading , relatedBy: .equal, toItem: imageCoverView!, attribute: .leading, multiplier: 1.0, constant: 0)
        
        let labelYConstraint = NSLayoutConstraint.init(item: songName!, attribute: .centerY, relatedBy: .equal, toItem: imageCoverView!, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        let labelHeight = NSLayoutConstraint.init(item: songName!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.height)
        
        let labelWidth = NSLayoutConstraint.init(item: songName!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.width)
        
        contentView.addConstraints([labelCenterX, labelYConstraint, labelHeight, labelWidth])
        
        
    }
    
    
    //MARK: Set Video
    var video: Video? {
        didSet {
            if let video = video {
                
//                backgroundImage?.contentMode = .scaleAspectFill
//                backgroundImage?.image = vinylImage
                
                imageView!.image = video.image
                imageView?.contentMode = .scaleAspectFill
                
                songName?.text = video.songName
                songName?.contentMode = .scaleAspectFill
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let standardHeight = videoConstants.cell.standardHeight
        
        let featuredHeight = videoConstants.cell.featuredHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.3
        
        let maxAlpha: CGFloat = 0.95
        
        imageCoverView!.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
//        backgroundImage!.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(0.5, delta)
        
        songName?.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
        
    }
    
}




