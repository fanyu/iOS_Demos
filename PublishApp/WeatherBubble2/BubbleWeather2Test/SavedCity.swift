//
//  SavedCity.swift
//  BubbleWeather2Test
//
//  Created by FanYu on 8/2/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct cSavedCity {
    static let SavedCity = "SavedCity"
    static let dataBaseID = "savedID"
}

class SavedCity: NSManagedObject {
    @NSManaged var savedCityName: String
    @NSManaged var savedID: NSNumber
    @NSManaged var savedCountry: String
    
    static func getAllCities() ->[SavedCity]? {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: cSavedCity.SavedCity)
        var error: NSError?
        
        let results = context.executeFetchRequest(fetchRequest, error: &error) as? [SavedCity]
        
        if error != nil {
            println("Could not save \(error), \(error?.userInfo)")
        }
        return results
    }
    
    static func getCityByID(idCity:Int) ->SavedCity? {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: cSavedCity.SavedCity)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [cSavedCity.dataBaseID, idCity])
        var error: NSError?
        
        let results = context.executeFetchRequest(fetchRequest, error: &error) as? [SavedCity]
        
        return results?.first
    }
    
    static func insertCity(city:String, country:String, id: Int) -> SavedCity? {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        // already have the city, so donot insert again
        if let cityByID = SavedCity.getCityByID(id) {
            return nil
        }
        
        let savedCity = NSEntityDescription.insertNewObjectForEntityForName(cSavedCity.SavedCity, inManagedObjectContext: context) as? SavedCity
        
        savedCity?.savedCityName = city
        savedCity?.savedCountry = country
        savedCity?.savedID = id
        weatherService.saveContext()
    
        return savedCity
    }
    
    static func removeCity(city: SavedCity) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        context.deleteObject(city)
    }
}