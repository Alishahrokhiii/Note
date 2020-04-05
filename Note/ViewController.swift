//
//  ViewController.swift
//  Note
//
//  Created by Seyed Ali Shahrokhi on 1/16/1399 AP.
//  Copyright © 1399 Seyed Ali Shahrokhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var TableViewNote: UITableView!
    
    
    let CellIdentifier = "CellIdentifier"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        guard let url = URL(string: "http://192.168.64.3/Service.php?action=select") else { return }
        
       let task = URLSession.shared.dataTask(with: url) { (data, response, erorr) in
         
        do {
            
        
            let records = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
            
            for record in records!{
                
               /// print((record as AnyObject).value(forKey: "task_desc")!)
                let note = StructNote()
                let task_IdStr = ((record) as AnyObject).value(forKey: "task_id")as? String
                note.task_Id = Int(task_IdStr!)
                note.task_title = (record as AnyObject).value(forKey: "task_title") as? String
                note.task_desc = (record as AnyObject).value(forKey: "task_desc") as? String
                note.task_done = (record as AnyObject).value(forKey: "task_done") as? Int
                
                 AppDelegate.notes.append(note)
            }
           
            
            
            DispatchQueue.main.async{
            self.TableViewNote.reloadData()
            }
        
        } catch {
                print("we had an erorr retriving data")
                
                
            }
        }
    

        task.resume()
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AppDelegate.notes.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let note = AppDelegate.notes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! CustomCell
        
        cell.LableTaskTitle.text = note.task_title
        
        cell.SwitchTaskDone.setOn((note.task_done != nil), animated: false)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VCEditNote = storyboard?.instantiateViewController(identifier: "ViewControllerEditNote") as! ViewControllerEditNote
        
        let note = AppDelegate.notes[indexPath.row]
        
        VCEditNote.task_id = note.task_Id
        VCEditNote.task_title = note.task_title
        VCEditNote.task_desc = note.task_desc
        VCEditNote.task_done = note.task_done
        navigationController?.pushViewController(VCEditNote, animated: true)
    }
    @IBAction func AddNewTask(_ sender: Any) {
        let VCEditNote = storyboard?.instantiateViewController(identifier: "ViewControllerEditNote") as! ViewControllerEditNote
        
         navigationController?.pushViewController(VCEditNote, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        TableViewNote.reloadData()
    }
}
