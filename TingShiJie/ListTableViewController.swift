
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
		
		self.tableView.rowHeight = 70
		self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg"))
		
		var channelData: AnyObject = readjson("channels")
		
		initialChannels(channelData.objectForKey("channels")!)
	}
	
	// MARK: - Table view data source
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.channels.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
		
		if (indexPath.row % 2 == 0) {
			cell.backgroundColor = UIColor.clearColor()
		}else{
			cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
			cell.textLabel!.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
			cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
		}
		
		let channel = self.channels[indexPath.row]
		
		cell.textLabel!.text = channel.name
		cell.detailTextLabel?.text = channel.country
		cell.imageView!.image = UIImage(named: channel.image!)
		
		cell.detailTextLabel?.textColor = UIColor.whiteColor()
		cell.textLabel!.textColor = UIColor.whiteColor()
		cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
		
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		var indexPath = self.tableView.indexPathForSelectedRow()!
		var audioController: AudioViewController = segue.destinationViewController as! AudioViewController
		audioController.channel = channels[indexPath.row]
	}
	
	
	func readjson(fileName: String) -> AnyObject {
		
		let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
		let data = NSData(contentsOfMappedFile: path!)
		let channelJson: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
		
		return channelJson!
	}
	
	func initialChannels(data: AnyObject) {
		for channelData in data as! [AnyObject] {
			var channel = Channel(name: channelData.objectForKey("name") as! String, info: channelData.objectForKey("info") as! String, url: channelData.objectForKey("url") as! String,
					image: channelData.objectForKey("image") as! String, country: channelData.objectForKey("country") as! String)
			self.channels.append(channel)
		}
	}
}
