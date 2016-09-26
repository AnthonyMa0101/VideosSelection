//
//  VideoSelectedLayout.swift
//  VideosSelectionView
//
//  Created by Anthony Ma on 10/9/2016.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

import UIKit

struct videoConstants {
    struct cell {
        
        static let standardHeight: CGFloat = 100.0
        
        static let featuredHeight: CGFloat = 280.0
    }
}

class VideoSelectedLayout: UICollectionViewLayout {
    
    let dragOffset: CGFloat = 180.0
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var featuredVideo: Int {
        get {
            return max(0, Int(collectionView!.contentOffset.y/dragOffset))
        }
    }
    
    var upcomingVideo: CGFloat {
        get {
            return (collectionView!.contentOffset.y/dragOffset) - CGFloat(featuredVideo)
        }
    }
    
    var width: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    var height: CGFloat {
        return collectionView!.bounds.height
    }
    
    var numberOfVideos: Int {
        get {
            return collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    override var collectionViewContentSize : CGSize {
        let contentHeight = (CGFloat(numberOfVideos) * dragOffset) + (height - dragOffset)
        
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        if cache.isEmpty {
        
        let standardHeight = videoConstants.cell.standardHeight
        let featuredHeight = videoConstants.cell.featuredHeight
        
        var frame = CGRect.zero
        
        var y: CGFloat = 0
        
        for item in 0..<numberOfVideos {
            
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.zIndex = item
            
            var height = standardHeight
            
            if indexPath.item == featuredVideo {
                
                let yOffset = standardHeight * upcomingVideo
                
                y = collectionView!.contentOffset.y - yOffset
                
                height = featuredHeight
            }
            
            else if indexPath.item == (featuredVideo + 1) && indexPath.item != numberOfVideos {
                
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * upcomingVideo, 0)
                y = maxY - height
                
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
            
        }
        collectionView?.reloadData()
        
    }
//        collectionView?.reloadData()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        let itemIndex = round(proposedContentOffset.y/dragOffset)
//        let yOffset = itemIndex * dragOffset
//        return CGPoint(x: 0, y: yOffset)
//    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
