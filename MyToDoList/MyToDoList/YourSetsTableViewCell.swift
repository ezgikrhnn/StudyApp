//
//  YourSetsTableViewCell.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 6.12.2023.
//

import UIKit


class YourSetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var setBackground: UIView!
    
    var veri: SetItem?
    
    var buttonTappedAction: (() -> Void)?
    
    @IBOutlet weak var labelHour: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func ButtonTapped(_ sender: Any) {
        print("BUTTON TIKLANDI")
        buttonTappedAction?()
    
}
        
        
}
