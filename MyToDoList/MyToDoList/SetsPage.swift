//
//  DetailPage.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 5.12.2023.
//

import UIKit

class SetsPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var sets = [SetItem]() //array
    
    let context1 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var YourSetsTableView: UITableView!
    
   
    @IBOutlet weak var LabelMotivation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        YourSetsTableView.dataSource = self
        YourSetsTableView.delegate = self
        configureItems()
        getAllSets()
        
       
      
       
    
    }
    
    private func configureItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(showTimePickerAlert))
    }
    
    @objc private func showTimePickerAlert() {
        MyToDoList.showTimePickerAlert(in: self) { formattedDate in
            // Kullanıcıdan alınan formattedDate'i kullanarak işlemleri yapabilirsiniz
            self.createSet(setTime: formattedDate)
        }
    }
    
    @objc func showTimePicker1(set: SetItem) {
        MyToDoList.showTimePicker1(in: self, set: set) { formattedDate in
            // Kullanıcıdan alınan formattedDate'i kullanarak işlemleri yapabilirsiniz
            self.updateSet(item: set, newTime: formattedDate)
        }
    }
    
    
    //MARK: TableView 3 Fonksiyonu
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let veri = sets[indexPath.row]
  
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "yourSetsCell", for: indexPath) as? YourSetsTableViewCell {
          
            
            cell.veri = veri
            cell.labelHour.text = veri.setTime
           
            cell.contentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 0.3)
            cell.backgroundColor = UIColor.clear
            cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 30, right: 16)
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor.white // Çizgi rengi
        
            cell.layer.cornerRadius = 8
         
            cell.buttonTappedAction = { [weak self] in
                let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
                    self?.showTimePicker1(set: veri)
                    // Edit'e tıklandığında yapılacak işlemleri buraya ekleyin
                    // Örneğin: self?.showTimePicker1(set: rowData)
                }))
                    
                sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                    // Delete'e tıklandığında yapılacak işlemleri buraya ekleyin
                    self?.deleteSet(item: veri)
                    // Örneğin: self?.deleteSet(item: rowData)
                }))
                
                self?.present(sheet, animated: true, completion: nil)
            }
            
            return cell
            }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70.0 // Hücre yüksekliğini istediğiniz değere ayarlayın
      }
    
    
   
        
        //bir hücreye tıklayınca "didSelect" otomatik olarak tetiklenir
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let veri = sets[indexPath.row]
        
        performSegue(withIdentifier: "toTimer", sender: veri)
      
        
      /**  let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
                self?.showTimePicker1(set: veri)
            }))
            
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                self?.deleteSet(item: veri)
            }))
            
        present(sheet, animated: true)**/
        
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTimer"{
            if let veri = sender as? SetItem {
                let gidilecekYer = segue.destination as! CounterPage
                gidilecekYer.veri = veri
                print("veri gidiyor")
            }
        }
    }
        
        
        
        //MARK: COREDATA FUNCTIONS
        //MARK: -Func Get All
        func getAllSets(){
            do{
                sets = try context1.fetch(SetItem.fetchRequest())
                DispatchQueue.main.async {
                    self.YourSetsTableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        
        //MARK: -Func Create Item
        func createSet(setTime: String){
            let newItem = SetItem(context: context1)
            newItem.setTime = setTime
            do{
                try context1.save()
                getAllSets()
            }catch{
                print(error.localizedDescription)
            }
        }
        
        //MARK: -Func Delete Item
        func deleteSet(item: SetItem){
            context1.delete(item)
            do{
                try context1.save()
                getAllSets()
            }catch{
                print(error.localizedDescription)
            }
        }
        
        //MARK: -Func Update Item
        func updateSet(item: SetItem, newTime : String){
            item.setTime = newTime
            do{
                try context1.save()
                getAllSets()
            }catch{
                print(error.localizedDescription)
            }
        }
    
}
