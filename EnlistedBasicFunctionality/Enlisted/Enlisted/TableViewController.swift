//
//  TableViewController.swift
//  Enlisted
//
//  Created by Monika on 2017-08-30.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var vacationModel: LocationInfo!
    var vacationDescriptions: [String] = []
    var vacationDetails: [String] = []
    
    var isSearching = false
    var foundMatches: [String] = []
    
    //start search bar overrides here
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            foundMatches = vacationDetails.filter({$0.contains(searchBar.text!)})
            tableView.reloadData()
        }
    }
    
    //deprecated.
    /*func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        if self.vacationDescriptions.count == 0 {
            self.foundMatches = []
            return
        }
        self.foundMatches = self.vacationDescriptions.filter({(aKeyword: String) -> Bool in
            if aKeyword.lowercased().contains(searchText.lowercased()){
                return true
            }
            else{
                return false
            }
        })
    }
    
    @nonobjc func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchText: searchString)
        return true
    }*/
    //end

    override func viewDidLoad() {
        super.viewDidLoad()
        //put all model logic here for easy access.
        vacationModel = LocationInfo()
        vacationModel.SeedLocationInfo(selectInitType: true)
        vacationDescriptions = vacationModel.nameeLocations
        vacationDetails = vacationModel.nameeDescriptions
        
        tableView.delegate = self
        searchBar.delegate = self
        tableView.dataSource = self
        searchBar.returnKeyType = .done

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return foundMatches.count
        }
        return vacationModel.nameeDescriptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VacationCell", for: indexPath) as? TableViewCell

        // Configure the cell...
        //fix storyboard/simulator issue where a previous hieght has been assigned automatically?
        self.tableView.rowHeight = 85
        if isSearching {
            cell?.vacationCellLocationName.text = foundMatches[indexPath.row]
            let imageIndex = vacationModel.nameeDescriptions.index(of: foundMatches[indexPath.row])
            cell?.vacationCellImageView.image = UIImage(named: vacationModel.nameeImage[imageIndex!])
            //cell?.vacationCellImageView.image = UIImage(named: "Beach")
            
        }
        else {
            cell?.vacationCellLocationName.text = vacationModel.nameeLocations[indexPath.row]
            cell?.vacationCellImageView.image = UIImage(named: vacationModel.nameeImage[indexPath.row])
        }

        return cell!
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let listVC = segue.destination as! ShowsCellsDetails
        //listVC.theName.text = "test"
        //listVC.theImage.image = UIImage(named: "Beach")
        //listVC.theDescription.text = "the description should be here now"
        if isSearching {
            listVC.theDescriptionPreGui = foundMatches[indexPath.row]
            let index = vacationModel.nameeDescriptions.index(of: foundMatches[indexPath.row])
            listVC.theImagePreGui = UIImage(named: vacationModel.nameeImage[index!])
            listVC.theNamePreGui = vacationModel.nameeLocations[index!]
            
        }
        else
        {
            listVC.theNamePreGui = vacationModel.nameeLocations[indexPath.row]//"test"
            listVC.theDescriptionPreGui = vacationModel.nameeDescriptions[indexPath.row]//"the description..."
            listVC.theImagePreGui = UIImage(named: vacationModel.nameeImage[indexPath.row])//UIImage(named: "Beach")
        }
    }
    
    /*override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }*/
    

}
