//
//  ToDoListCell.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 5.12.2023.
//

import UIKit

class ToDoListCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    
    let rightImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(named: "dots") // Kullanacağınız resmin adını ekleyin
         imageView.isUserInteractionEnabled = true // Görüntüye tıklanabilirlik özelliği ekleyin
         return imageView
     }()

    // @IBOutlet weak var imageViewDots: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 20.0
        cellBackground.layer.opacity = 0.7
        cellBackground.layer.borderColor = UIColor.white.cgColor
        cellBackground.layer.borderWidth = 2.0
        cellBackground.layer.shadowColor = UIColor(named: "darkpurple")?.cgColor
        cellBackground.layer.shadowOpacity = 1.0
        cellBackground.layer.shadowOffset = CGSize(width: 5, height: 5) // Gölge ofseti
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
