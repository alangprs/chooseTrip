//確認行程頁面

import UIKit

class ChooseDataViewController: UIViewController {
    //顯示label 文字
    @IBOutlet var showChooseDataLabel: [UILabel]!
    @IBOutlet weak var showChooseDastaImage: UIImageView!
    @IBOutlet weak var showChooseDataTex: UITextView!
    var fields:Fields
    //存準備傳去第三頁資料
    var value = Int()
    var sum = Int()
    var name = String()
    var data = String()
        
    //接第一頁資料
    init?(coder:NSCoder,fields:Fields){
        self.fields = fields
        super .init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //在背景抓照片
    func catchImage() {
        if let url = URL(string: fields.fields.Image){
            URLSession.shared.dataTask(with: url) { data, respond, error in
                if let data = data{
                    DispatchQueue.main.async {
                        self.showChooseDastaImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
   //選擇人數
    @IBAction func chooseDataStrpper(_ sender: UIStepper) {
        value = Int(sender.value+1)
        showChooseDataLabel[3].text = "\(value)" //顯示目前選擇人數
        sum = fields.fields.Price * value //總金額
        showChooseDataLabel[4].text = "\(sum)"
       
    }
    @IBSegueAction func showPage3(_ coder: NSCoder) -> SingUpTableViewController? {
        data = fields.fields.Data
        name = fields.fields.Name
        return SingUpTableViewController(coder: coder, value: value, sum: sum, name: name, data: data)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showChooseDataLabel[0].text = fields.fields.Name
        showChooseDataLabel[1].text = fields.fields.Data
        showChooseDataLabel[2].text = "$\(fields.fields.Price)RM" //顯示第一頁選到行程的金額
        showChooseDataLabel[4].text = "\(fields.fields.Price)"
        showChooseDataTex.text = fields.fields.TripData
        catchImage() 
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
