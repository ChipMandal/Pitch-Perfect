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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var fileUrl =  NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("movie_quote",ofType:"mp3")!) {
            player = AVAudioPlayer(contentsOfURL: fileUrl, error:nil)
            player.enableRate = true
            //print(fileUrl)

        } else {
            print("Could not find file")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func snailButton(sender: UIButton) {
//
//        var player = AVAudioPlayer(contentsOfURL: fileUrl, error:nil);
        player.rate = 0.5
        player.play()
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
