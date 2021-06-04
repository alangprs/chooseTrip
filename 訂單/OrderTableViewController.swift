//

//訂單頁面

import UIKit

class OrderTableViewController: UITableViewController {
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var getOderArray = [OderFields]()
    //抓網路資料
    func catchOderData(){
        indicator.isHidden = false
        let urlstr = URL(string: "https://api.airtable.com/v0/app5ZRbQye9xZvWSR/Table%201?maxRecords=3&view=Grid%20view")!
        var request = URLRequest(url: urlstr)
        request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, respond, error in
            if let data = data{
                do {
                    let recordsResponse = try JSONDecoder().decode(OderResponse.self, from: data)
                    self.getOderArray = recordsResponse.records
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.indicator.isHidden = true
                    }
                    
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    //左右滑動刪除cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let controller = UIAlertController(title: "確認刪除此筆訂單？", message: "", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "確認", style: .default) { (_) in
                
                let urlstr = URL(string: "https://api.airtable.com/v0/app5ZRbQye9xZvWSR/Table%201" + "/" + self.getOderArray[indexPath.row].id)!
                var request = URLRequest(url: urlstr)
                request.httpMethod = "DELETE"
                request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request) { data, respond, error in
                    if let data = data,
                       let status = String(data:data,encoding: .utf8){
                        DispatchQueue.main.async {
                            print("看刪除",status)
                            
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                            self.catchOderData()
                        }
                    }
                    
                }.resume()
                self.getOderArray.remove(at: indexPath.row)
            }
            let noAction = UIAlertAction(title: "取消", style: .default, handler: nil)
            controller.addAction(yesAction)
            controller.addAction(noAction)
            present(controller, animated: true, completion: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        catchOderData()//抓網路資料
       
    }
//    //回到選購畫面
//    @IBAction func backHomeTabelViewController(_ sender: UIBarButtonItem) {
//        if let controller = storyboard?.instantiateViewController(identifier: "\(HomeTableViewController.self)"){
//            controller.modalPresentationStyle = .fullScreen
//            present(controller, animated: true, completion: nil)
//        }
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getOderArray.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderCellTableViewCell.self)", for: indexPath) as? OrderCellTableViewCell else{return UITableViewCell()}
        let item = getOderArray[indexPath.row]
        cell.oderLabel[0].text = item.fields.StrokeName
        cell.oderLabel[1].text = "聯絡人：\(item.fields.Name)"
        cell.oderLabel[2].text = "人數\(item.fields.NumberOfPeople)"
        cell.oderLabel[3].text = "RM $\(item.fields.TotalSum)"

        // Configure the cell...

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
