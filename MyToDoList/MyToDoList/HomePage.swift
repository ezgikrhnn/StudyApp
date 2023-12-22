//
//  ViewController.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 5.12.2023.
//

import UIKit

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var ToDoListTableView: UITableView!
    
    private var models = [ToDoListItem]() //array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(ToDoListTableView)
        getAllItems()
        configureItems()
        
        
        // Günün güncel tarihini al
        let currentDate = Date()

        // Tarih biçimlendirme işlemi
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM EEEE" // Gün, Ay ve Haftanın Günü
        dateFormatter.locale = Locale(identifier: "en_US") // İngilizce için ABD lokasyonu
        let formattedDate = dateFormatter.string(from: currentDate)

                // Navigation Controller'ın başlığını özel etiket ile değiştir
        self.navigationItem.title = "Hi Ezgi, " + formattedDate +  " ☀︎"
        
        ToDoListTableView.delegate = self
        ToDoListTableView.dataSource = self
        ToDoListTableView.backgroundColor = UIColor.clear
        ToDoListTableView.separatorStyle = .none
        ToDoListTableView.isOpaque = false
    }

    private func configureItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    
    //MARK: FUNC BUTTON +(ADD)
 /**bu fonksiyon kullanıcı girdisini alır ve ardından bu girdiyi işlemek üzere createItem metodunu çağırır.*/
    @objc private func didTapAdd(){
    let alert = UIAlertController(title: "⭐︎ New Task ⭐︎", message: "Add a new task 🚀", preferredStyle: .alert)
    alert.addTextField(configurationHandler: nil)
    /// UIAlertAction oluşturulması ve UIAlertController'a eklenmesi
    alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
        guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
            /// Eğer metin girişi boş ise işlem yapılmaz
            return
        }
        self?.createItem(name: text)
    }))
    present(alert, animated: true)
}
    
    
    //MARK: TableView 3 Fonksiyonu
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
       
        cell.textLabel?.text = model.name
        cell.backgroundColor = UIColor.clear
        
        cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        cell.layer.cornerRadius = 10
        
        

        return cell
    }
    
    //bir hücreye tıklayınca "didSelect" otomatik olarak tetiklenir
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        /// UIAlertAction oluşturulması ve UIAlertController'a eklenmesi
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "Edit your task", message: "✨", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    /// Eğer metin girişi boş ise işlem yapılmaz
                    return
                }
                self?.updateItem(item: item, newName: newName)
            }))
            self.present(alert, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
        
    
    //MARK: COREDATA FUNCTIONS
    //MARK: -Func Get All
    func getAllItems(){
        do{
             models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.ToDoListTableView.reloadData()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    //MARK: -Func Create Item
    func createItem(name: String){
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do{
            try context.save()
            getAllItems()
        }catch{
            print(error.localizedDescription)
        }
    }

    //MARK: -Func Delete Item
    func deleteItem(item: ToDoListItem){
        context.delete(item)
        do{
            try context.save()
            getAllItems()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    //MARK: -Func Update Item
    func updateItem(item: ToDoListItem, newName : String){
        item.name = newName
        do{
            try context.save()
            getAllItems()
        }catch{
            print(error.localizedDescription)
        }
    }
}




