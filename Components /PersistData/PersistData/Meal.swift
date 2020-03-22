//
//  Meal.swift
//  PersistData
//
//  Created by FanYu on 16/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//
import UIKit

class Meal: NSObject, NSCoding {
    
    // properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    
    // MARK: - Initialization 
    //
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
    }
    
    
    // MARK: - NSCoding
    // encode
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    // decode
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        self.init(name: name, photo: photo, rating: rating)
    }
    
    // save data
    static func saveMeals(meals: [Meal]) {
        let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfullSave {
            print("Failed to save meals...")
        }
    }
    
    // retrieve
    static func retrieveMeals() -> [Meal]{
        let meals = NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
        return meals!
    }
    
}
