//
//  OrderCellTableViewCell.swift
//  選購旅遊行程
//
//  Created by 翁燮羽 on 2021/6/1.
//

import UIKit

class OrderCellTableViewCell: UITableViewCell {
  
    @IBOutlet var oderLabel: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }

}
