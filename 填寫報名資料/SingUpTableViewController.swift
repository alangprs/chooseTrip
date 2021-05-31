//資料填寫

import UIKit


class SingUpTableViewController: UITableViewController {
    
    //view 上文字
    @IBOutlet var singUpShowLabel: [UILabel]!
    var uploadData = [Fieldss]() //要上傳的資料
    let personalData = PersonalData.allCases //自定義的資料填寫cell內容
    //接第二頁傳來的資料
    var page3Data:PageData
    var texData = [String?]() //讀texfied文字
    //存讀到輸入的基本資料
    var arrayOfNames = [String]()
    //文字顯示
    func showLabel(){
        singUpShowLabel[0].text = "行程名稱：\(page3Data.name!)"
        singUpShowLabel[1].text = "每個\(page3Data.data!)"
        singUpShowLabel[2].text = "目前人數：\(page3Data.value!)人"
        singUpShowLabel[3].text = "總金額：\(page3Data.sum!)ＲＭ"
    }
    
    init?(coder:NSCoder,page3Data:PageData){
        self.page3Data = page3Data
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLabel()
    }
    
    
    
    //讀cell裡面 輸入的文字
    func catchEnterData(){
            var i = 0
            while i < personalData.count {
                let indexPath = IndexPath(row: i, section: 0)
                let cell : SIngUpTableViewCell? = (self.tableView.cellForRow(at: indexPath) as! SIngUpTableViewCell?)
                if let item = cell?.singUpTex.text {
                    arrayOfNames.append(item)
                }
                i = i + 1
            }
    }
    //上傳資料
    func postSingData(){
        catchEnterData()
        let singUpItem = UploadData(records: [.init(fields: .init(StrokeName: page3Data.name!,
                                                                  Name: arrayOfNames[0], Birthday: arrayOfNames[1], IDNumber: arrayOfNames[2], PhoneNumber: arrayOfNames[3],      NumberOfPeople: page3Data.value!, TotalSum: page3Data.sum!                   ))])
        print("要上傳的資料",singUpItem)
        let url = URL(string: "https://api.airtable.com/v0/app5ZRbQye9xZvWSR/Table%201?maxRecords=3&view=Grid%20view")!
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization")
        if let data = try? JSONEncoder().encode(singUpItem){
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { data, respond, error in
                if let data = data{
                    let content = String(data:data,encoding: .utf8)
                    print(content!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else{
                    print(error)
                }
            }.resume()
        }
        
    }
    //跳出未填寫完資料通知
//    func showNotFinshDataAlertController(){
//        let controller = UIAlertController(title: "請確認資料是否填寫完整", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "確定", style: .default, handler: nil)
//        controller.addAction(action)
//        present(controller, animated: true, completion: nil)
//    }
    //跳出資料確認通知
    func showConfirmDataAlerController(){
        catchEnterData()
        let controller = UIAlertController(title: "確認送出訂單", message: "\n \(page3Data.name!) \n \(page3Data.data!)\n \(page3Data.value!)人 \n 總金額:\(page3Data.sum!)ＲＭ \n 聯絡人資訊 \n 姓名:\(arrayOfNames[0])\n 生日:\(arrayOfNames[1])\n護照號碼:\(arrayOfNames[2])\n 電話號碼:\(arrayOfNames[3])", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "確認", style: .default) { _ in
            self.postSingData() //點選確認 執行上傳資料func
        }
        let notAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        controller.addAction(yesAction)
        controller.addAction(notAction)
        present(controller, animated: true, completion: nil)
    }
    
    //送出資料
    @IBAction func postData(_ sender: UIButton) {
        catchEnterData() // 讀取cell填寫內容
        showConfirmDataAlerController()//跳出資料確認通知
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //等於上一頁選擇人數
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personalData.count //等於資料格數
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SIngUpTableViewCell.self)", for: indexPath) as? SIngUpTableViewCell else { return UITableViewCell() }
        
        let row = personalData[indexPath.row]
       
        switch row {
        //顯示每個cell自定義文字
        case .Name:
            let name = personalData[indexPath.row]
            cell.singUpLabel.text = name.rawValue
        case .Birthday:
            let birthday = personalData[indexPath.row]
            cell.singUpLabel.text = birthday.rawValue
        case .IDNumber:
            let idNumber = personalData[indexPath.row]
            cell.singUpLabel.text = idNumber.rawValue
        case .PhoneNumber:
            let phoneNumber = personalData[indexPath.row]
            cell.singUpLabel.text = phoneNumber.rawValue
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
