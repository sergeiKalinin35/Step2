//
//  MainViewController.swift
//  Step2
//
//  Created by Sergey on 17.08.2021.
//
import UserNotifications
import UIKit



class MainViewController: UICollectionViewController {
    
    var models = [MyReminder]()

    override func viewDidLoad() {
        super.viewDidLoad()

  
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
                self.collectionView.reloadData()
            
                
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

    
    @IBAction func didTapTest() {
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CollectionViewCell
        cell.oneLabel?.text = models[indexPath.item].target
        cell.titleLabel.text = models[indexPath.item].title
    
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY  hh:mm"
        
        cell.timeLabel?.text = formatter.string(from: date)
        
        return cell
    }

   
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 30, height: 100)
    }
    
    
    
}

struct MyReminder {
    
    let target: String
    let title: String
    let date: Date
 
}
