//填寫資料cell

import UIKit

class SIngUpTableViewCell: UITableViewCell {

    
    @IBOutlet weak var singUpLabel: UILabel!
    
    @IBOutlet weak var singUpTex: UITextField!
    
    func f(){
        if singUpTex.text?.isEmpty != nil{
            print("有值喔")
        }else{
            print("沒有值")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
