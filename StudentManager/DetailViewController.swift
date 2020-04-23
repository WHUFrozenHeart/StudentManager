//
//  DetailViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/24.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var instituteLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var birthplaceLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    var studentName:String!
    private var students:[Student]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getStudent()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getStudent(){
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "Student", in:managedObjectContext)
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.entity = entity
        do
        {
            students = try managedObjectContext.fetch(request) as [Student]
        }catch {
            print("Failed to fetch")
        }
        for student in students{
            if student.name == studentName{
                nameLabel.text = student.name
                numberLabel.text = student.number
                instituteLabel.text = student.institute
                idLabel.text = student.id
                birthplaceLabel.text = student.live
                phoneLabel.text = student.phone
                mailLabel.text = student.mail
            }
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "Student", in:managedObjectContext)
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.entity = entity
        do
        {
            let results:[AnyObject]? = try managedObjectContext.fetch(request)
            for student:Student in results as! [Student]{
                if student.name==nameLabel.text
                {
                    student.managedObjectContext?.delete(student)
                    do{
                        try student.managedObjectContext?.save()
                    }catch{
                        print("failed to save")
                    }
                }
            }
        }catch {
            print("Failed to fetch")
           
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancel"{
            print("cancel")
        }else if segue.identifier == "back"{
            print("back")
        }else if segue.identifier == "changeStudent"{
            let changeStudent = segue.destination as! ChangeStudentViewController
            changeStudent.studentName = studentName
            print("studentDetail")
        }
    }
}
