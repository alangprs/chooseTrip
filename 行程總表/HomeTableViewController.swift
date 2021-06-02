//首頁

import UIKit

class HomeTableViewController: UITableViewController {

    var tripData = [Fields]()
    
    //抓AirTable資料
    func catchData(){
        let urlstr = URL(string: "https://api.airtable.com/v0/app1pJYMNqBvFt6ce/Table%201")!
        var request = URLRequest(url: urlstr)
        request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, respond, error in
                let decoder = JSONDecoder()
                
                if let data = data{
                    do {
                        let recordsResponse = try decoder.decode(RecordsResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        self.tripData = recordsResponse.records
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catchData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //傳資料到下一頁
    @IBSegueAction func pickData(_ coder: NSCoder) -> ChooseDataViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            return ChooseDataViewController(coder: coder,fields: tripData[row])
        }
        return nil
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("數量01",tripData.count)
        return tripData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CatchHomeCellTableViewCell.self)", for: indexPath) as? CatchHomeCellTableViewCell
        else{return UITableViewCell()}
        let row = tripData[indexPath.row]
        cell.cellTable[0].text = "行程名稱：\(row.fields.Name)"
        cell.cellTable[1].text = "出發日期：\(row.fields.Data)"
        cell.cellTable[2].text = "行程天數：\(row.fields.TripItme)"
        cell.cellTable[3].text = "$\(row.fields.Price)ＲＭ"
        
        if let url = URL(string: row.fields.Image){
            URLSession.shared.dataTask(with: url) { data, respond, error in
                DispatchQueue.main.async {
                    cell.cellImage.image = UIImage(data: data!)
                    
                }
            }.resume()
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
