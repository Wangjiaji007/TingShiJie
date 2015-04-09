
//
//  ListTableViewController.swift
//  TingShiJie
//
//  Created by Jiaji Wang on 4/2/15.
//  Copyright (c) 2015 Jiaji Wang. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var channels = [Channel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var channelData: AnyObject = readjson("channels")
    
        initialChannels(channelData.objectForKey("channels")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   /* override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    } */

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
        let channel = self.channels[indexPath.row]

        cell.textLabel.text = channel.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var indexPath = self.tableView.indexPathForSelectedRow()!
        var audioController: AudioViewController = segue.destinationViewController as AudioViewController
        audioController.channel = channels[indexPath.row]
    }

    
    func readjson(fileName: String) -> AnyObject {
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        let data = NSData(contentsOfMappedFile: path!)
        let channelJson: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        return channelJson!
    }
    
    func initialChannels(data: AnyObject) {
        for channelData in data as [AnyObject] {
            var channel = Channel(name: channelData.objectForKey("name") as String, info: channelData.objectForKey("info") as String, url: channelData.objectForKey("url") as String)
            self.channels.append(channel)
        }
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
