//
//  Constants.swift
//  Smack
//
//  Created by Amir on 2/24/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "http://192.168.60.41:3005/v1"
//let BASE_URL = "http://127.0.0.1:3005/v1"
let URL_REGISTER = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_USER_ADD = "\(BASE_URL)/user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)/user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel"

let HEADER = ["Content-Type" : "application/json; charset=utf-8"]

let BEARER_HEADER = ["Content-Type" : "application/json; charset=utf-8", "Authorization" : "Bearer \(AuthService.instance.authToken)"]



let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"

// Colors
let smackPurplePlaceHolder = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 0.5)

//Nottification
let NOTIFICATION_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIFICATION_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIFICATION_CURRENT_CHANNEL = Notification.Name("currentChannel")

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL_KEY = "userEmail"

enum AvatarType{
    case dark
    case light
}
