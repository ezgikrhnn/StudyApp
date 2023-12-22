//
//  TimePickerFunctions.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 8.12.2023.
//

import UIKit


func showTimePickerAlert(in viewController: UIViewController, completion: @escaping (String) -> Void) {
    let alert = UIAlertController(title: "⭐︎ New Set ⭐︎", message: "select your hours 🚀\n\n", preferredStyle: .actionSheet)
    
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .time
    datePicker.locale = Locale(identifier: "tr_TR")
    alert.view.addSubview(datePicker)
    
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
    datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60).isActive = true
    
    let addAction = UIAlertAction(title: "Submit", style: .default) { _ in
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: selectedDate)
        completion(formattedDate)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alert.addAction(addAction)
    alert.addAction(cancelAction)
    
    viewController.present(alert, animated: true, completion: nil)
}

func showTimePicker1(in viewController: UIViewController, set: SetItem, completion: @escaping (String) -> Void) {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .time
    datePicker.locale = Locale(identifier: "tr_TR")
    
    let alert = UIAlertController(title: "Edit your working hour", message: "\n\n",  preferredStyle: .alert)
    alert.view.addSubview(datePicker)
    
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
    datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 47).isActive = true
    
    alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: selectedDate)
        completion(formattedDate)
    }))
    
    viewController.present(alert, animated: true)
}
