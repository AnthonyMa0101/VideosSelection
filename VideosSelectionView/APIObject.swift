//
//  APIObject.swift
//  ProfileCreation
//
//  Created by Anthony Ma on 16/8/2016.
//  Copyright © 2016 Anthony Ma. All rights reserved.
//

//https://www.googleapis.com/youtube/v3/search?&part=snippet,id&order=date&channelId=UCuI48V3qSHZvZimYgFNJYJg&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=

//queue

import UIKit

class APIObject: NSObject {

    static let sharedInstance = APIObject()
    
    //API variables
    var leftSideTitleAPI: String = "https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&maxResults=1&type=channel&q="
    
    var leftSideChannelAPI: String = "https://www.googleapis.com/youtube/v3/search?&part=snippet,id&order=date&channelId="
    
    var APIKey: String = "&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken="
    
    //channel name and ID
    var userChannelTitle: String = "Beats by Nav"
    var channelId: String = "UCuI48V3qSHZvZimYgFNJYJg"
    
    //final API string
    var API: String = ""

    var dictionaryAPI: NSDictionary?
    var infoDictionaryAPI: NSDictionary?
    
    var userVideos: [Video]!
    
    // get channel ID
    func getChannelAPI() {
        
        let channelTitle: String = self.userChannelTitle
        let leftSide = String("\(leftSideTitleAPI) + \(channelTitle)")
        self.API = String("\(String(describing: leftSide) + String(APIKey))")

        print(self.API)
    
    }
    
    // API Call
    func getChannelID(_ callback: @escaping (String) -> Void) {
        self.getChannelAPI()
        let APIKey = self.API
        let url = URL.init(string: APIKey as String)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"

        DispatchQueue.global(qos: .background).async {
            
            let task = URLSession.shared.dataTask(with: request) {
                
                data, response, error in
     
                if (error == nil && data != nil) {
                    do {
                        let dictionaryData = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                        
                        print(dictionaryData)
                        
                        if let items = dictionaryData["items"] as? [[String: AnyObject]] {
                            if let first = items.first  {
                                if let property = first["id"] as? [String: String] {
                                    if let cid = property["channelId"] {
                                        self.channelId = cid
                                    }
                                }
                            }
                        }
                        
                        DispatchQueue.main.async(execute: {
                            callback(self.channelId)
                        })
                        
                    } catch {
                        fatalError()
                    }
                }
            }; task.resume()
        }
    }

    // get video
    func getVideoAPI() {
        
        let channelID: String = self.channelId
        let leftSide = String(leftSideChannelAPI + channelID)
        self.API = String(leftSide! + APIKey)
        print(self.API)
        
    }
    
    //API Call
    func getVideos(_ callback: @escaping ([Video]) -> Void) {
        self.getVideoAPI()
        let APIKey = self.API
        var result:[Video] = []
        let url = URL.init(string: APIKey as String)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        
        DispatchQueue.global(qos: .background).async {
            
            let task = URLSession.shared.dataTask(with: request) {
                
                data, response, error in
                
                if (error == nil && data != nil) {
                    do {
                        let dictionaryData = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                        
                        if let items = dictionaryData["items"] as? [[String: AnyObject]] {
                            for item in items {
                                
                                let video = Video()
                                
                                if let songName = item["snippet"] {
                                    let title = songName["title"] as? String
                                    if let title = title {
                                        if title.isEmpty {
                                            continue
                                        }
                                        video.songName = title
                                        print(video.songName)
                                    }
                                }
                                
                                if let thumbnailImages = item["snippet"] {
                                    let images = thumbnailImages["thumbnails"] as? [String: AnyObject]
                                    let imageURL = images!["high"] as? [String: AnyObject]
                                    if let image = imageURL!["url"] as? String {
                                        if image.isEmpty {
                                            continue
                                        }
                                        video.imageData = self.imageToData(image)
                                        video.image = UIImage.init(data: video.imageData!)
                                    }
                                    
                                    if let id = item["id"] {
                                        let videoId = id["videoId"] as? String
                                        if let videoId = videoId {
                                            if videoId.isEmpty {
                                                continue
                                            }
                                            video.videoId = videoId
                                            print(video.videoId)
                                            print(video.image)
                                            result.append(video)
                                        }
                                    }
                                    
                                }
                            }
                            self.userVideos = result
                        }
                        
                        DispatchQueue.main.async(execute: {
                            callback(self.userVideos)
                            
                        })
                        
                    } catch {
                        fatalError()
                    }
                }
                
            }; task.resume()
        }
    }
    
    func imageToData(_ urlString: String) -> Data {
        let url = URL.init(string: urlString)
        let imageData = try? Data.init(contentsOf: url!)
        return imageData!
    }
    
}
