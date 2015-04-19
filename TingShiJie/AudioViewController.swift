//
//  AudioViewController.swift
//  TingShiJie
//
//  Created by Jiaji Wang on 4/7/15.
//  Copyright (c) 2015 Jiaji Wang. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class AudioViewController: UIViewController {
	
	@IBOutlet weak var playButton: UIButton!
	var player:  AVPlayer!
	var channel: Channel!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.player = AVPlayer(URL: NSURL(string: channel.url!))
		
		if NSClassFromString("MPNowPlayingInfoCenter") != nil {
			let image:UIImage = UIImage(named: self.channel.image!)!
			let albumArt = MPMediaItemArtwork(image: image)
			var songInfo: NSMutableDictionary = [
				MPMediaItemPropertyTitle: self.channel.name!,
				MPMediaItemPropertyArtwork: albumArt
			]
			MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo as [NSObject : AnyObject]
		}
		
		AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
		UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	
	@IBAction func buttonPressed(sender: AnyObject) {
		toggle()
	}
	
	func toggle() {
		if playButton.titleLabel?.text == "Play" {
			playRadio()
		} else {
			pauseRadio()
		}
	}
	
	func playRadio() {
		player.play()
		playButton.setTitle("Pause", forState: UIControlState.Normal)
	}
	
	func pauseRadio() {
		player.pause()
		playButton.setTitle("Play", forState: UIControlState.Normal)
	}
	
	override func remoteControlReceivedWithEvent(event: UIEvent) {
		if event.type == UIEventType.RemoteControl {
			if event.subtype == UIEventSubtype.RemoteControlPlay {
				playRadio()
			}
		}
	}
	
}
