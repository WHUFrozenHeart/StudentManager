//
//  LoginViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/24.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountTextField.text = ""
        passwordTextField.text = ""

    }
    
    func  judge() -> Bool{
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "User", in:managedObjectContext)
        let request = NSFetchRequest<User>(entityName: "User")
        request.entity = entity
        do
        {
            let results:[AnyObject]? = try managedObjectContext.fetch(request)
            for user:User in results as! [User]{
                if user.name == accountTextField.text && user.password==passwordTextField.text
                {
                    AppDelegate.userAccount = user.name
                    AppDelegate.userPassword = user.password
                    return true
                }
            }
            return false
        }catch {
            print("Failed to fetch")
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  judge() {
            print("seccess")
        }else{
            let alertController = UIAlertController(title: "提示", message: "账号或者密码错误", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController,animated: true,completion: nil)
            return
        }
    }
    
    @IBAction func accountTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func passwordTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        exit(0)
    }
}
