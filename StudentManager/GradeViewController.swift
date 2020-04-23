//
//  GradeViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/22.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData

class GradeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var gradeTableView: UITableView!
    let cellID = "GradeTableCell"
    private var grades:[Grade]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gradeTableView.register(GradeTableCell.self, forCellReuseIdentifier: cellID)
        let nib = UINib(nibName: "GradeTableCell", bundle: nil)
        gradeTableView.register(nib, forCellReuseIdentifier: cellID)
        gradeTableView.rowHeight = 72
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gradeTableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! GradeTableCell
        let grade = grades[indexPath.row]
        cell.gradeLabel?.text = grade.grades
        cell.courseNameLabel?.text = grade.course
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "成绩"
    }
    
    @IBAction func serchButtonAction(_ sender: Any) {
        var tempGrades:[Grade]!
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "Grade", in:managedObjectContext)
        let request = NSFetchRequest<Grade>(entityName: "Grade")
        request.entity = entity
        do
        {
            tempGrades = try managedObjectContext.fetch(request) as [Grade]
        }catch {
            print("Failed to fetch")
        }
        let studentName = serchTextField.text
        if studentName == "" {
            let alertController = UIAlertController(title: "提示", message: "你未输入任何内容，请重试", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController,animated: true,completion: nil)
            return
        }
        grades.removeAll()
        for grade in tempGrades{
            if grade.name == studentName{
                grades.append(grade)
            }
        }
        if grades.count == 0 {
            let alertController = UIAlertController(title: "提示", message: "未找到你输入的姓名", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController,animated: true,completion: nil)
            return
        }
        gradeTableView.reloadData()
        let alertController = UIAlertController(title: "提示", message: "查询成功", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true,completion: nil)
    }
    
    @IBAction func serchTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        serchTextField.resignFirstResponder()
    }
}
