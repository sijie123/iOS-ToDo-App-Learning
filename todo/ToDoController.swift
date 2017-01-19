//
//  ToDoController.swift
//  todo
//
//  Created by Si Jie on 16/1/17.
//  Copyright © 2017 TinkerTanker. All rights reserved.
//

import UIKit

class ToDoController: UIViewController, UITextFieldDelegate {

    var inputViewX = UIView()
    var id: Int = -1
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var detailsInput: UITextView!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var saveBtnMenu: UIBarButtonItem!
    @IBAction func saveBtn(_ sender: Any) {
        saveAndExit()
        
        
    }
    @IBAction func saveBtnMenu(_ sender: Any) {
        saveAndExit()
        
        //print("\(id)")
        //print("SAVED!")
    }
    func validate() -> Bool {
        let title = titleInput?.text
        let date = dateInput?.text
        if (title != nil && date != nil) {
            if (title != "" && date != "") { return true }
        }
        return false
    }
    func saveAndExit() {
        if (validate()) {
            
            let title = titleInput?.text
            var details = detailsInput?.text
            let date = dateInput?.text
            if (details == nil) { details = "" }
            let item: NSMutableArray = [title, details, date]
            //var tempItems:NSMutableArray = []
            
            var items: NSMutableArray
            let toDoList = UserDefaults.standard.object(forKey: "toDoList")
            if let tempItems = toDoList as? NSArray {
                items = NSMutableArray(array: tempItems)
                print(type(of: items))
                //items.replaceObjects(at: <#T##IndexSet#>, with: <#T##[Any]#>)
                items.add(item)
                //toDoItems = tempItems
            }
            else {
                items = [item]
            }
            UserDefaults.standard.set(items, forKey: "toDoList")
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        else {
            
        }
        

    }

    
    
    @IBAction func datePressed(_ sender: UITextField) {
        update(date: Date())
        inputViewX = UIView(frame: CGRect(x:0,y: 0, width: self.view.frame.width,height: 240))
        
        
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
        datePicker.addTarget(self, action: #selector(ToDoController.datePickerValueChanged(_:)), for: .valueChanged)
        inputViewX.addSubview(datePicker)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2),y: 0,width: 100,height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.cyan, for: UIControlState.highlighted)
        
        
        //datePicker.addTarget(self, action: #selector(ToDoController.datePickerValueChanged(_:)), for: .valueChanged)
        
        doneButton.addTarget(self, action: #selector(ToDoController.hideEdit), for: UIControlEvents.touchUpInside) // set button click event
        
        inputViewX.addSubview(doneButton) // add Button to UIView

        sender.inputView = inputViewX
        
        
    }
    
    
    //@IBAction func saveBtnMenu(_ sender: UIBarButtonItem) {
    //}

    /*@IBAction func saveBtn(_ sender: UIButton) {
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        if (id != -1) {
            var toDoItems:NSArray = []
            let toDoList = UserDefaults.standard.object(forKey: "toDoList")
            if let tempItems = toDoList as? NSArray {
                toDoItems = tempItems[id] as! NSArray
                titleInput?.text = String(describing: toDoItems[0])
                detailsInput?.text = String(describing: toDoItems[1])
                dateInput?.text = String(describing: toDoItems[2])
                saveBtn?.setTitle("Update", for: UIControlState.normal)
                saveBtn?.setTitle("Update", for: UIControlState.highlighted)
                self.saveBtnMenu?.title = "Update"
                //saveBtnMenu?.setTitle("Update", for: UIControlState.normal)
                //saveBtnMenu?.setTitle("Update", for: UIControlState.highlighted)
            }
            else {
                //There's some really bad problem we have here :(
            }
        }
                // Do any additional setup after loading the view.
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ToDoController.hideEdit))
        //view.addGestureRecognizer(tapGesture)
        //self.titleInput.delegate = self
    }
    
    func update(date: Date) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
        let selectedDate: String = dateFormatter.string(from: date)
        dateInput?.text = selectedDate
    }
    
    func datePickerValueChanged(_ sender:UIDatePicker) {
        update(date: sender.date)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        //datePicker.resignFirstResponder()
    }
    func hideEdit() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
