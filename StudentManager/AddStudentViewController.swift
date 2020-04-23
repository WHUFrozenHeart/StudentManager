//
//  AddStudentViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/30.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData

class AddStudentViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var instituteTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var birthplaceTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    private var flag = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = ""
        numberTextField.text = ""
        instituteTextField.text = ""
        idTextField.text = ""
        birthplaceTextField.text = ""
        phoneTextField.text = ""
        mailTextField.text = ""
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func addButtonAction(_ sender: Any) {
        if nameTextField.text != "" && numberTextField.text != "" && instituteTextField.text != "" && idTextField.text != "" && birthplaceTextField.text != "" && phoneTextField.text != "" && mailTextField.text != "" {
            if judge() {
                let context=AppDelegate.viewContainer
                let student=Student(context: context)
                student.id = idTextField.text
                student.name = nameTextField.text
                student.institute = instituteTextField.text
                student.number = numberTextField.text
                student.live = birthplaceTextField.text
                student.phone = phoneTextField.text
                student.mail = mailTextField.text
                do{
                    try student.managedObjectContext?.save()
                }catch
                {
                    let alertController = UIAlertController(title: "提示", message: "添加失败", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    present(alertController,animated: true,completion: nil)
                    print("failed to save")
                }
                flag = true
            }else{
                let alertController = UIAlertController(title: "提示", message: "添加学生已存在", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertController.addAction(alertAction)
                present(alertController,animated: true,completion: nil)
            }
        
        }else{
            let alertController = UIAlertController(title: "提示", message: "信息未填写完", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController,animated: true,completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" && flag{
            print("添加")
        }else if segue.identifier == "cancel"{
            print("取消")
        }
    }
    
    func  judge() -> Bool{
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "Student", in:managedObjectContext)
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.entity = entity
        do
        {
            let results:[AnyObject]? = try managedObjectContext.fetch(request)
            for student:Student in results as! [Student]{
                if student.name == nameTextField.text
                {
                    return false
                }
            }
            return true
        }catch {
            print("Failed to fetch")
            return false
        }
    }
    
    @IBAction func nameTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
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
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        nameTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        instituteTextField.resignFirstResponder()
        idTextField.resignFirstResponder()
        birthplaceTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
    }
    
}
