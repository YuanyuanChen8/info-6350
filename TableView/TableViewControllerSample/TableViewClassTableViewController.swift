import UIKit

class TableViewClassTableViewController: UITableViewController {

    let foods = ["Hot pot", "Pizza", "Pho","Ramen"]
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = foods[indexPath.row]

        return cell
    }
    

   

}
