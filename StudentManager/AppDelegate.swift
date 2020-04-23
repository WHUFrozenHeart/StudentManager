//
//  AppDelegate.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/22.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var userAccount:String!
    static var userPassword:String!
    
    var window: UIWindow?
    static var persistentContainer:NSPersistentContainer{
        return (UIApplication.shared.delegate as!AppDelegate).persistentContainer
    }

    static var viewContainer:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       
        let context=AppDelegate.viewContainer
        let person=User(context: context)
        person.name="吴笛"
        person.password="123456"
        /*
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "Student", in:managedObjectContext)
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.entity = entity
        do
        {
            let results:[AnyObject]? = try managedObjectContext.fetch(request)
            for user:Student in results as! [Student]{
                user.managedObjectContext?.delete(user)
                do
                {
                    try user.managedObjectContext?.save()
                }catch{
                    print("not delete")
                }
            }
            
        }catch {
            print("Failed to fetch")
        }
      */
       /*
      let user=Student(context: context)
        user.name="ynl"
        user.id="095"
        user.live="wh"
        user.phone="0319"
        user.institute="cs"
      
        let user3=Student(context: context)
        user3.name="zck"
        user3.id="095"
        user3.live="wh"
        user3.phone="0319"
        user3.institute="cs"
        
        */
        /*let grade=Grade(context: context)
        grade.name="wd"
        grade.course="IOS"
        grade.grades="90"
        
        let grade1=Grade(context: context)
        grade1.name="wd"
        grade1.course="IOQ"
        grade1.grades="92 "
        
        
        let grade2=Grade(context: context)
        grade2.name="wd"
        grade2.course="IOP"
        grade2.grades="91"*/
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "StudentManager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

