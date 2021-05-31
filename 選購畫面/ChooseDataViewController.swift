//確認行程頁面

import UIKit

class ChooseDataViewController: UIViewController {
    //顯示label 文字
    @IBOutlet var showChooseDataLabel: [UILabel]!
    @IBOutlet weak var showChooseDastaImage: UIImageView!
    @IBOutlet weak var showChooseDataTex: UITextView!
    var value = 0
    var fields:Fields
    //存準備傳去第三頁資料
    var page2Data = PageData()   
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
    //跳出人數選擇錯誤通知
    func peopleNumberAler(){
        let alertController = UIAlertController(title: "人數最少一人", message: "", preferredStyle: .alert)
        let alerAction =  UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(alerAction)
        present(alertController, animated: true, completion: nil)
    }
   //選擇人數
    @IBAction func chooseDataStrpper(_ sender: UIStepper) {
        page2Data.value = Int(sender.value)
        showChooseDataLabel[3].text = "\(page2Data.value!)" //顯示目前選擇人數
        page2Data.sum = fields.fields.Price * page2Data.value!
        showChooseDataLabel[4].text = "\(page2Data.sum!)"
    }
    @IBSegueAction func showPage3(_ coder: NSCoder) -> SingUpTableViewController? {
        
        if page2Data.value! < 1{
            peopleNumberAler() //跳出人數不足通知
        }
        
        return SingUpTableViewController(coder: coder, page3Data: page2Data)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showChooseDataLabel[0].text = fields.fields.Name
        showChooseDataLabel[1].text = fields.fields.Data
        showChooseDataLabel[2].text = "$\(fields.fields.Price)RM" //顯示第一頁選到行程的金額
//        showChooseDataLabel[4].text = "\(fields.fields.Price)"
        showChooseDataTex.text = fields.fields.TripData
        catchImage()//背景抓圖片
        page2Data.name = fields.fields.Name
        page2Data.data = fields.fields.Data
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
