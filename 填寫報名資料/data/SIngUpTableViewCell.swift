//填寫資料cell

import UIKit

class SIngUpTableViewCell: UITableViewCell {

    
    @IBOutlet weak var singUpLabel: UILabel!
    
    @IBOutlet weak var singUpTex: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
