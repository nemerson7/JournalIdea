//
//  EntriesTableViewController.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/7/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021



import UIKit

class EntriesTableViewController: UITableViewController {

    var myAppDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAppDelegate = UIApplication.shared.delegate as? AppDelegate

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func newEntryButtonAction(_ sender: Any) {
        self.myAppDelegate?.myModel.addEntry(title: "sample title", content: "lorem ipsum dolor &c")
        if let lMyTableView = self.view as? UITableView {
            lMyTableView.reloadData()
        
            
            if let unwrappedDelegate = self.myAppDelegate {
                let tempIndex = IndexPath(row: unwrappedDelegate.myModel.entries.count - 1, section: 0)
                lMyTableView.selectRow(at: tempIndex, animated: true, scrollPosition: .none)
                
                //calling this because programmatic selection does not call it
                self.tableView(self.tableView, didSelectRowAt: tempIndex)
            }
        }
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let unwrappedDelegate = self.myAppDelegate {
            return unwrappedDelegate.myModel.titlesArray.count
        } else { return 1 }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        // Configure the cell...
        if let unwrappedDelegate = self.myAppDelegate {
            cell.textLabel?.text = "\(indexPath.row + 1)" + ". " + unwrappedDelegate.myModel.titlesArray[indexPath.row]
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let lMyTableView = self.view as? UITableView {
            lMyTableView.rowHeight = 50
            lMyTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showEntry", sender: self.myAppDelegate?.myModel.entries[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let openedEntry = segue.destination as? EntryViewController {
            if let castedSender = sender as? Entry {
                openedEntry.myEntry = castedSender
            }
        }
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.myAppDelegate?.myModel.entries.remove(at: indexPath.row)
            if let lMyTableView = self.view as? UITableView {
                lMyTableView.reloadData()
            }
        }
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
