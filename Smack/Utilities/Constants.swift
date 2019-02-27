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
let URL_REGISTER = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_USER_ADD = "\(BASE_URL)/user/add"

let HEADER = ["Content-Type" : "application/json; charset=utf-8"]

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL_KEY = "userEmail"
