//
//  utils.swift
//  ExtranetApp
//
//  Created by antoine beneteau on 2017-06-06.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import JSSAlertView

let userDefaults = UserDefaults.standard
var student = Student()
var notificationsUtils = NotificationsUtils()
var manager = Alamofire.SessionManager.default
var configuration = URLSessionConfiguration.default


public func cleanMarksJSON(string: String) -> String {
    
    var newString = string.replacingOccurrences(of: "X.net.RM.getIcon(\"BulletWhite\")", with: "\"\"")
    newString = newString.replacingOccurrences(of: "\"leaf\":true", with: "\"leaf\":\"true\"")
    newString = newString.replacingOccurrences(of: "\"leaf\":false", with: "\"leaf\":\"false\"")
    newString = newString.replacingOccurrences(of: " \"total\": 0", with: "\"total\": \"0\"")
    newString = newString.replacingOccurrences(of: "Ã©", with: "é")
    newString = newString.replacingOccurrences(of: "Ã¨", with: "è")
    newString = newString.replacingOccurrences(of: "Ã", with: "à")
    
    return newString
}


public func cleanMarksJSONinfos(string: String) -> String {
    
    var newString = string.replacingOccurrences(of: "<script type=\"text/javascript\">Ext.ComponentManager.onAvailable(\"ExtranetContent\",", with: "")
    newString = newString.replacingOccurrences(of: "function(){", with: "")
    newString = newString.replacingOccurrences(of: "Ext.net.addTo(\"ExtranetContent\",", with: "")
    newString = newString.replacingOccurrences(of: ");</script>", with: "")
    newString = newString.replacingOccurrences(of: ", false);}", with: "")
    newString = newString.replacingOccurrences(of: ",listeners:{afterrender:{fn:function(item){Ext.net.DirectMethod.request({url: '/Student/Absence/Summary', timeout: 600000, cleanRequest: true, eventMask: {showMask:true} });}}}", with: "")
    newString = newString.replacingOccurrences(of: "id:\"ExtranetRightContent\",border:false,xtype:\"panel\",flex:3,", with: "")
    newString = newString.replacingOccurrences(of: "{cls:\"x-panel-alert\",style:\"padding: 5px\",items:[{cls:\"alert-label\",xtype:\"netlabel\",text:\"No alerts\"}],layout:\"vbox\",title:\"Important Messages\"},", with: "")
    newString = newString.replacingOccurrences(of: "cls:\"x-panel-infoperso\",style:\"padding: 5px\",", with: "")
    newString = newString.replacingOccurrences(of: ",{border:false,minHeight:170,style:\"padding: 5px\",xtype:\"container\",flex:1,items:[{xtype:\"netimage\",imageUrl:\"/Student/Home/Photo\"}]}", with: "")
    newString = newString.replacingOccurrences(of: "border:false,padding:0,xtype:\"fieldset\",flex:2,", with: "")
    newString = newString.replacingOccurrences(of: "id:\"idfa34d15a698236ef\",xtype:\"displayfield\",", with: "")
    newString = newString.replacingOccurrences(of: "id:\"id9a187f56aec236ef\",cls:\"alert-detail\",xtype:\"displayfield\",", with: "")
    newString = newString.replacingOccurrences(of: "id:\"EXT_ADDRESS\",xtype:\"displayfield\",", with: "")
    newString = newString.replacingOccurrences(of: "id:\"EXT_PLACE\",cls:\"alert-detail\",xtype:\"displayfield\",", with: "")
    newString = newString.replacingOccurrences(of: "id:\"EXT_TELEPHONEMOBILE\",cls:\"alert-detail\",xtype:\"displayfield\",", with: "")
    newString = newString.replacingOccurrences(of: "xtype:\"fieldcontainer\",", with: "")
    newString = newString.replacingOccurrences(of: "id:\"idd0b11e8e78ad36ef\",xtype:\"displayfield\",", with: "")
    newString = newString.replacingOccurrences(of: ",fieldLabel:\"E-mail\",labelWidth:50", with: "")
    newString = newString.replacingOccurrences(of: ",layout:\"hbox\",title:\"Personal Data\"", with: "")
    newString = newString.replacingOccurrences(of: "items:", with: "\"items\":")
    newString = newString.replacingOccurrences(of: "id:", with: "\"id\":")
    newString = newString.replacingOccurrences(of: "xtype:", with: "\"xtype\":")
    newString = newString.replacingOccurrences(of: "value:", with: "\"value\":")
    newString = newString.replacingOccurrences(of: "cls:", with: "\"cls\":")
    newString = newString.replacingOccurrences(of: "layout:", with: "\"layout\":")
    newString = newString.replacingOccurrences(of: "[{\"items\":[{\"items\":[{\"items\":", with: "{\"items\":[{\"items\":[{\"items\":")
    newString = newString.replacingOccurrences(of: "]}]}]", with: "]}]}")
    newString = newString.replacingOccurrences(of: "Name : ", with: "")
    newString = newString.replacingOccurrences(of: "Birthdate : ", with: "")
    newString = newString.replacingOccurrences(of: "Address : ", with: "")
    newString = newString.replacingOccurrences(of: "City : ", with: "")
    newString = newString.replacingOccurrences(of: "Mobile Phone : ", with: "")
    
    return newString
}


public func convertToDictionary(text: String) -> Any? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

// Convert from NSData to json object
public func nsdataToJSON(data: NSData) -> Any? {
    do {
        return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil
}


public func moveToLogin() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let naviVC = storyBoard.instantiateViewController(withIdentifier: "LoginView")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = naviVC
}

public func moveToProfile() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let naviVC = storyBoard.instantiateViewController(withIdentifier: "MainView")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = naviVC
}


public func showAlert(title: String, message: String, color: UIColor, sender: UIViewController) {
    let alertview = JSSAlertView().show(sender,
                                        title: title,
                                        text: message,
                                        buttonText: "Fermer",
                                        color: color)
    alertview.setTitleFont("Roboto-Bold")
    alertview.setTextFont("Roboto-Regular")
    alertview.setButtonFont("Roboto-Medium")
    alertview.setTextTheme(.light)
}

extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = characters.index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":
            return "iPod Touch 5"
        case "iPod7,1":
            return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone8,1":
            return "iPhone 6s"
        case "iPhone8,2":
            return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":
            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":
            return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":
            return "iPad Air"
        case "iPad5,3", "iPad5,4":
            return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":
            return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":
            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":
            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":
            return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":
            return "iPad Pro"
        case "AppleTV5,3":
            return "Apple TV"
        case "i386", "x86_64":
            return "Simulator"
        default:
            return identifier
        }
}
}
