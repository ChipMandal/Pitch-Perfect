//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Chitradip Mandal on 3/17/15.
//  Copyright (c) 2015 Chitradip Mandal. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player:AVAudioPlayer!
    var recieveRecordedAudio:RecordingData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVAudioPlayer(contentsOfURL: recieveRecordedAudio.filePath, error: nil)
        player.enableRate = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hareButton(sender: UIButton) {
        playWithRate(2.0)
    }

    @IBAction func stopButton(sender: UIButton) {
        player.stop();
        player.currentTime = 0.0
    }
    
    func playWithRate(rate: Float) {
        player.stop();
        player.rate = rate;
        player.play();
    }
    @IBAction func snailButton(sender: UIButton) {
//
//        var player = AVAudioPlayer(contentsOfURL: fileUrl, error:nil);
        playWithRate(0.5)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
