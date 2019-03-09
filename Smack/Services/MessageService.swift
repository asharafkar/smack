//
//  MessageService.swift
//  Smack
//
//  Created by Amir on 3/8/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var currentChannel: Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler){
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else { return }
                
//                do{
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                }catch{
//                    debugPrint(error as Any)
//                }
            
                
                do{
                    if let items = try JSON(data: data).array{

                        for item in items{
                            let name = item["name"].stringValue
                            let channelDescription = item["decription"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                    }
                }catch{
                    debugPrint(error as Any)
                }
                
                NotificationCenter.default.post(name: NOTIFICATION_CHANNELS_LOADED, object: nil)
                completion(true)
                
            }else{
                
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
}
