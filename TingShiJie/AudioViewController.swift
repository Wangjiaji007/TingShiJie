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
	@IBOutlet weak var channelBrand: UIImageView!
	@IBOutlet weak var channelInfo: UITextView!
	
	var player:  AVPlayer!
	var channel: Channel!
	var spinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = channel.name
		
		initPlayer()
		initChannelInfo()
		initPlayButtonStyle()
//		initSpinner()

		if NSClassFromString("MPNowPlayingInfoCenter") != nil {
			let image:UIImage = UIImage(named: channel.image!)!
			let albumArt = MPMediaItemArtwork(image: image)
			var songInfo: NSMutableDictionary = [
				MPMediaItemPropertyTitle: channel.name!,
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
			} else if event.subtype == UIEventSubtype.RemoteControlPause {
				pauseRadio()
			} else if event.subtype == UIEventSubtype.RemoteControlTogglePlayPause {
				toggle()
			}
		}
	}
	
	func initPlayer() {
		player = AVPlayer(URL: NSURL(string: channel.url!))
//		player.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil)
		channelBrand.image = UIImage(named: channel.image!)
	}
	
	func initChannelInfo() {
		channelInfo.textAlignment = NSTextAlignment.Center
		channelInfo.text = channel.info
		channelInfo.backgroundColor = UIColor.clearColor()
		channelInfo.textColor = UIColor.whiteColor()
		channelInfo.editable = false
	}
	
	func initPlayButtonStyle() {
		playButton.layer.borderWidth = 1
		playButton.layer.borderColor = UIColor.whiteColor().CGColor
		playButton.layer.cornerRadius = 5
	}
	
//	func initSpinner() {
//		spinner = UIActivityIndicatorView.new()
//		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
//		spinner.frame = playButton.bounds
//		spinner.hidesWhenStopped = true
//		playButton.addSubview(spinner)
//	}
	
//	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
//		if (object as! NSObject == player && keyPath == "status") {
//			if (player.status == AVPlayerStatus.ReadyToPlay) {
//				spinner.stopAnimating()
//			} else if (player.status == AVPlayerStatus.Unknown) {
//				spinner.startAnimating()
//			}
//		}
//	}
	
	
}
