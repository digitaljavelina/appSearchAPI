//
//  EmployeeSearch.swift
//  Colleagues
//
//  Created by Michael Henry on 1/27/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

extension Employee {
  public static let domainIdentifier = "com.raywenderlich.colleagues.employee"
  
  public var userActivityInfo: [NSObject: AnyObject] {
    return ["id": objectId]
  }
  
  public var attributeSet: CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContact as String)
    attributeSet.title = name
    attributeSet.contentDescription = "\(department), \(title)\n\(phone)"
    attributeSet.thumbnailData = UIImageJPEGRepresentation(loadPicture(), 0.9)
    attributeSet.supportsPhoneCall = true
    attributeSet.phoneNumbers = [phone]
    attributeSet.emailAddresses = [email]
    attributeSet.keywords = skills
    
    return attributeSet
  }
  
  public var userActivity: NSUserActivity {
    let activity = NSUserActivity(activityType: Employee.domainIdentifier)
    activity.title = name
    activity.userInfo = userActivityInfo
    activity.keywords = [email, department]
    
    activity.contentAttributeSet = attributeSet
    
    return activity
  }
}
