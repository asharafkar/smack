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
    var messages = [Message]()
    
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
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_GET_MESSAGE)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                self.clearMessage()
                guard let data = response.data else { return }
                do{
                if let json = try JSON(data: data).array{
                    
                    for item in json{
                        
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let username = item["userName"].stringValue
                        let userAvatarImage = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, username: username, channelId: channelId, userAvatarImage: userAvatarImage, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        
                        self.messages.append(message)
                    }
                    
                    print(self.messages)
                    completion(true)
                }
                }catch{
                    debugPrint(response.result.error as! String)
                }
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
    func clearMessage(){
        messages.removeAll()
    }
    
}
