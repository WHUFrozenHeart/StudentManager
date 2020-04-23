//
//  MainPageViewController.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/22.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit
import CoreData

class MainPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var studentTableView: UITableView!
    private var students:[Student]!
    private let cellID = "StudentTableCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getStudents()
        
        studentTableView.register(StudentTableCell.self, forCellReuseIdentifier: self.cellID)
        let nib = UINib(nibName: "StudentTableCell", bundle: nil)
        studentTableView.register(nib, forCellReuseIdentifier: self.cellID)
        studentTableView.rowHeight = 72
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        serchTextField.text = ""
        studentTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getStudents(){
        let managedObjectContext = AppDelegate.viewContainer
        let entity = NSEntityDescription.entity(forEntityName: "Student", in:managedObjectContext)
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.entity = entity
        do
        {
            students = try managedObjectContext.fetch(request) as [Student]
            students.sort(by: sortStudent(firstStudent:secondStudent:))
        }catch {
            print("Failed to fetch")
        }
    }
    
    func sortStudent(firstStudent:Student,secondStudent:Student) -> Bool{
        return firstStudent.name! < secondStudent.name!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentTableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! StudentTableCell
        cell.studentNameLabel?.text = studentNameForDisplay(atIndexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "学生"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentTabelCell = studentTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "studentDetail", sender: studentTabelCell)
    }
    
    @IBAction func serchButtonAction(_ sender: Any) {
        if serchTextField.text == "" {
            getStudents()
            studentTableView.reloadData()
        }else{
            var flag = false
            for student in students{
                if student.name == serchTextField.text{
                    flag = true
                    let tempStudent = student
                    students.removeAll()
                    students.append(tempStudent)
                    studentTableView.reloadData()
                    let alertController = UIAlertController(title: "提示", message: "查找成功", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    present(alertController,animated: true,completion: nil)
                }
            }
            if !flag{
                let alertController = UIAlertController(title: "提示", message: "未找到你输入的姓名", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertController.addAction(alertAction)
                present(alertController,animated: true,completion: nil)
            }
        }
    }
    
    func studentNameForDisplay(atIndexPath indexPath: NSIndexPath) -> String? {
        let student = students[indexPath.row]
        let studentName = student.name
        return studentName != nil ? studentName : nil
    }
    
    @IBAction func serchTextFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        serchTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addStudent"{
            print("addStudent")
        }else if segue.identifier == "studentDetail"{
            let studentTabelCell = sender as! UITableViewCell
            let indexPath = studentTableView.indexPath(for: studentTabelCell)!
            let studentName = studentNameForDisplay(atIndexPath: indexPath as NSIndexPath)
            let studentDetail = segue.destination as! DetailViewController
            studentDetail.studentName = studentName
            print("studentDetail")
        }
    }
}
