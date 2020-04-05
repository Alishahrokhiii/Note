//
//  ViewControllerEditNote.swift
//  Note
//
//  Created by Seyed Ali Shahrokhi on 1/16/1399 AP.
//  Copyright © 1399 Seyed Ali Shahrokhi. All rights reserved.
//

import UIKit

class ViewControllerEditNote: UIViewController {

    @IBOutlet weak var edtTaskTitle: UITextField!
    @IBOutlet weak var SwitchTaskDone: UISwitch!
    @IBOutlet weak var txtTaskDesc: UITextView!
    
    internal var task_id:Int!
    internal var task_title:String!
    internal var task_desc:String!
    internal var task_done:Int!
    //
    let note = StructNote()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if task_id != nil
        {
        // Do any additional setup after loading the view.
        edtTaskTitle.text = task_title
        SwitchTaskDone.setOn((task_done == 1 ? true : false), animated: false)
        txtTaskDesc.text = task_desc
        }
      
    }
  
    @IBAction func SaveData(_ sender: Any) {
        
        print(task_id)
        if task_id == nil {
        let note = StructNote()
        note.task_Id = task_id
        note.task_title = edtTaskTitle.text
        note.task_desc = txtTaskDesc.text
        note.task_done = (SwitchTaskDone.isOn ? 1 : 0)
        

        var dictionary = Dictionary<String, AnyObject>()
        
        dictionary["task_id"] = note.task_Id as AnyObject?
        dictionary["task_title"] = note.task_title as AnyObject?
        dictionary["task_desc"] = note.task_desc as AnyObject?
        dictionary["task_done"] = note.task_done as AnyObject?
       
        guard let url = URL(string: "http://192.168.64.3/Service.php?action=insert") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = TimeInterval(10)
        
               do {
               let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions(rawValue:0))
                
                request.httpBody = jsonData
               }catch{
                   print("JSON ERORR")
               }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (nsdata, response, erorr) in
            let task_id = String(data :nsdata!,encoding: String.Encoding.utf8)
            note.task_Id = Int(task_id!)
            AppDelegate.notes.append(note)
            DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
            }
        }
        task.resume()
        
  ///      let task = URLSession.shared.dataTask(with: request) { (data, response, erorr) in
           // let data = String(data: data, encoding: NSUTF8StringEncoding)
            
        }else{
            
            var dictionary = Dictionary<String, AnyObject>()
             
            dictionary["task_id"] = task_id as AnyObject?
            dictionary["task_title"] = edtTaskTitle.text as AnyObject?
            dictionary["task_desc"] = txtTaskDesc.text as AnyObject?
            dictionary["task_done"] = (SwitchTaskDone.isOn ? 1 : 0) as AnyObject
            
             guard let url = URL(string: "http://192.168.64.3/Service.php?action=update") else { return }
             
             var request = URLRequest(url: url)
             request.httpMethod = "POST"
             request.timeoutInterval = TimeInterval(10)
             
                    do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions(rawValue:0))
                     
                     request.httpBody = jsonData
                    }catch{
                        print("JSON ERORR")
                    }
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.addValue("application/json", forHTTPHeaderField: "Accept")
             
             let task = URLSession.shared.dataTask(with: request) { (nsdata, response, erorr) in
                
                let serverResponse = String(data: nsdata!, encoding: String.Encoding.utf8)
                if serverResponse == "recourd updated successfulluy"
                {
                 for i in 0..<AppDelegate.notes.count {
                    if  AppDelegate.notes[i].task_Id   == self.task_id {
                        DispatchQueue.main.async{
                        AppDelegate.notes[i].task_title = self.edtTaskTitle.text
                        AppDelegate.notes[i].task_desc =  self.txtTaskDesc.text
                        AppDelegate.notes[i].task_done = (self.SwitchTaskDone.isOn ? 1 : 0)
                        }
                     }
                 }
                 DispatchQueue.main.async{
                 self.navigationController?.popToRootViewController(animated: true)
                    }
             }
            }
             task.resume()
            
            
        }
    }
    @IBAction func DeleteRecord(_ sender: Any) {
        
        var dictionary = Dictionary<String, AnyObject>()
                    
                   dictionary["task_id"] = task_id as AnyObject?
                   
                    guard let url = URL(string: "http://192.168.64.3/Service.php?action=delete") else { return }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.timeoutInterval = TimeInterval(10)
                    
                           do {
                           let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions(rawValue:0))
                            
                            request.httpBody = jsonData
                           }catch{
                               print("JSON ERORR")
                           }
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    let task = URLSession.shared.dataTask(with: request) { (nsdata, response, erorr) in
                       
                       let serverResponse = String(data: nsdata!, encoding: String.Encoding.utf8)
                       if serverResponse == "OK"
                       {
                        for i in 0..<AppDelegate.notes.count {
                        if  AppDelegate.notes[i].task_Id   == self.task_id {
                            AppDelegate.notes.remove(at: i)
                         
                         }
                        }
                       }
                        else{
                            print("Erorr Delete")
                        }
                           
                    }
                   
                    task.resume()
                   
        
        }
        
    }
    
    
