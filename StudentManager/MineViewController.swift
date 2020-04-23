//
//  MineViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/25.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData
class MineViewController: UIViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountLabel.text = AppDelegate.userAccount
        passwordLabel.text = AppDelegate.userPassword
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func changeButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "修改密码", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "请输入新密码"
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange), name: UITextField.textDidChangeNotification, object: textField)
        })
        let okAction = UIAlertAction(title: "确认", style: .default, handler: {(action: UIAlertAction!) -> Void in
            let password = ((alertController.textFields?.first)! as UITextField).text
            let managedObjectContext = AppDelegate.viewContainer
            let entity = NSEntityDescription.entity(forEntityName: "User", in:managedObjectContext)
            let request = NSFetchRequest<User>(entityName: "User")
            request.entity = entity
            do
            {
                let results:[AnyObject]? = try managedObjectContext.fetch(request)
                for user:User in results as! [User]{
                    if user.name == AppDelegate.userAccount
                    {
                        AppDelegate.userAccount = user.name
                        AppDelegate.userPassword = password
                        self.accountLabel.text = AppDelegate.userAccount
                        self.passwordLabel.text = AppDelegate.userPassword
                        user.password=password
                        do{
                            try user.managedObjectContext?.save()
                        }catch{
                            print("not save")
                        }
                    }
                }
            
            }catch {
                print("Failed to fetch")
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        okAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController,animated: true,completion: nil)
    }
    
    @objc func alertTextFieldDidChange(){
        let alertController = self.presentedViewController as! UIAlertController
        let password = (alertController.textFields?.first)! as UITextField
        let okAction = alertController.actions.last! as UIAlertAction
        if (password.text?.count)! >= 6 {
            okAction.isEnabled = true
        }else{
            okAction.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exit"{
            print("exit")
        }
    }
}
