//
//  LanguageHelper.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/26.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

let UserLanguage = "UserLanguage"
let AppleLanguages = "AppleLanguages"

class LanguageHelper {
    
    static let shareInstance = LanguageHelper()
    
    let def = UserDefaults.standard
    var bundle: Bundle?
    
    class func getString(key: String) -> String {
        
        let bundle = LanguageHelper.shareInstance.bundle
        let str = bundle?.localizedString(forKey: key, value: nil, table: nil)
        return str!
    }
    
    func initUserLanguage() {
        
        var string: String = def.value(forKey: UserLanguage) as! String? ?? ""
        
        if string == "" {
            let languages = def.object(forKey: AppleLanguages) as? NSArray
            if languages?.count != 0 {
                let current = languages?.object(at: 0) as? String
                if current != nil {
                    string = current!
                    def.set(current, forKey: UserLanguage)
                    def.synchronize()
                }
            }
        }
        
        string = string.replacingOccurrences(of: "-CN", with: "")
        string = string.replacingOccurrences(of: "-US", with: "")
        var path = Bundle.main.path(forResource:string , ofType: "lproj")
        if path == nil {
            path = Bundle.main.path(forResource:"en" , ofType: "lproj")
        }
        
        bundle = Bundle(path: path!)
    }
    
    func setLanguage(language: String) {
        
        let path = Bundle.main.path(forResource:language , ofType: "lproj")
        bundle = Bundle(path: path!)
        def.set(language, forKey: UserLanguage)
        def.synchronize()
    }
}
