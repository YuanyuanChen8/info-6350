import UIKit

class TableViewClassTableViewController: UITableViewController {

    let contacts = ["Hot pot", "Pizza", "Pho","Ramen"]
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = contacts[indexPath.row]

        return cell
    }
    

   

}
