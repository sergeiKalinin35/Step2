//
//  MainViewController.swift
//  Step2
//
//  Created by Sergey on 17.08.2021.
//
import UserNotifications
import UIKit



class MainViewController: UITableViewController {
    
    var models = [MyReminder]()

   
    @IBOutlet var tab: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   tableView.rowHeight = 80
        
        //добавляем кнопку edit
        navigationItem.leftBarButtonItem = editButtonItem
        
    }

    @IBAction func didTapAdd() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else { return }
        vc.title = "TARGET"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { titleText, bodyText, targetDates in
            

        
        
        
      
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyReminder(target: titleText, title: bodyText, date: targetDates)
                self.models.append(new)
                self.tableView.reloadData()
            
                
                let content = UNMutableNotificationContent()
                content.title = titleText
                content.sound = .default
                content.body = bodyText
                
                
                let targetDate = targetDates
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                from: targetDate) ,
                                                           repeats: false)
                
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                        
                    }
                    
                })
                
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    // создаем кнопку боковую
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .delete
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                  tableView.deselectRow(at: indexPath, animated: true)
      
        }
    
    

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! TableViewCell
        
        cell.oneLabel?.text = models[indexPath.row].target
        cell.titleLabel.text = models[indexPath.row].title
    
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
            formatter.locale = Locale(identifier: localeID!)
        formatter.dateFormat = "HH:mm 🕐  EEEE, MMM d, yyyy"
        
        cell.timeLabel?.text = formatter.string(from: date)
   
       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 80
      }
    
    // удаление ячейки
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             models.remove(at: indexPath.row)
             tab.deleteRows(at: [indexPath], with: .automatic)
         }
    
     }
        // удаляем revome и возвращаем insert
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
           let currenModel =  models.remove(at: sourceIndexPath.row)
            models.insert(currenModel, at: destinationIndexPath.row)
        }
}
    // снять выделение с ячейки и переходим инициирует переход
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    //создаем кнопку и убираем боковое меню для редактирования navigationItem.leftBarButtonItem = editButtonItem для передвижени  строк
  //  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
  //      .none
   // }
    
  //  override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
 //       false
 //   }
 
    
    


struct MyReminder {
    
    let target: String
    let title: String
    let date: Date
 
}


