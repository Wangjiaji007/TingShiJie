//
//  AudioViewController.swift
//  TingShiJie
//
//  Created by Jiaji Wang on 4/7/15.
//  Copyright (c) 2015 Jiaji Wang. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    var player:AVPlayer = AVPlayer(URL: NSURL(string: "http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-eieuk"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
