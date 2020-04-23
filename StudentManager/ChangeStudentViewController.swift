//
//  ChangeStudentViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/30.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData

class ChangeStudentViewController: UIViewController {

    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var instituteTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var birthplaceTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
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
                studentNameLabel.text = student.name
                numberTextField.text = student.number
                instituteTextField.text = student.institute
                idTextField.text = student.id
                birthplaceTextField.text = student.live
                phoneTextField.text = student.phone
                mailTextField.text = student.mail
            }
        }
    }
    
    @IBAction func numberTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func instituteTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func idTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func birthplaceTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func phoneTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func mailTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any){
        numberTextField.resignFirstResponder()
        instituteTextField.resignFirstResponder()
        idTextField.resignFirstResponder()
        birthplaceTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "change"{
            print("change")
        }else if segue.identifier == "cancel"{
            let studentDetail = segue.destination as! DetailViewController
            studentDetail.studentName = studentName
            print("cancel")
        }
    }
    
    @IBAction func changeButtonAction(_ sender: Any) {
        if numberTextField.text != "" && instituteTextField.text != "" && idTextField.text != "" && birthplaceTextField.text != "" && phoneTextField.text != "" && mailTextField.text != "" {
            let managedObjectContext = AppDelegate.viewContainer
            let entity = NSEntityDescription.entity(forEntityName: "Student", in:managedObjectContext)
            let request = NSFetchRequest<Student>(entityName: "Student")
            request.entity = entity
            do{
            let results:[AnyObject]? = try managedObjectContext.fetch(request)
            for student:Student in results as! [Student]{
                if student.name==studentNameLabel.text
                {
                    student.id=idTextField.text
                    student.institute=instituteTextField.text
                    student.number=numberTextField.text
                    student.live=birthplaceTextField.text
                    student.phone=phoneTextField.text
                    student.mail=mailTextField.text
                    do{
                        try student.managedObjectContext?.save()
                    }catch
                    {
                        let alertController = UIAlertController(title: "提示", message: "修改失败", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        present(alertController,animated: true,completion: nil)
                        print("failed to save")
                    }
                }
            }
            }catch{
                let alertController = UIAlertController(title: "提示", message: "修改失败", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertController.addAction(alertAction)
                present(alertController,animated: true,completion: nil)
                print("Failed to fetch")
            }
        }
    }
}
