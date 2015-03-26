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
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile:AVAudioFile!
    var pitchNode:AVAudioUnitTimePitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVAudioPlayer(contentsOfURL: recieveRecordedAudio.filePath, error: nil)
        player.enableRate = true
        

        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        //let distortion = audioEngine.mainMixerNode;
        pitchNode = AVAudioUnitTimePitch()
        audioFile = AVAudioFile(forReading: recieveRecordedAudio.filePath, error: nil)
        audioEngine.attachNode(pitchNode)
        audioEngine.connect(audioPlayerNode, to: pitchNode, format: audioFile.processingFormat)
        audioEngine.connect(pitchNode, to: audioEngine.outputNode, format: audioFile.processingFormat)
       
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
      stopAllAudio()
    }
    
    func stopAllAudio() {
        player.stop();
        player.currentTime = 0.0
        
        audioPlayerNode.stop()
        audioEngine.stop()
        audioPlayerNode.reset()
    }
    
    func playWithRate(rate: Float) {
        stopAllAudio()
        
        player.rate = rate;
        player.play();
    }
    @IBAction func snailButton(sender: UIButton) {
//
//        var player = AVAudioPlayer(contentsOfURL: fileUrl, error:nil);
        playWithRate(0.5)

    }


    @IBAction func chipmunkButton(sender: UIButton) {
        playWithPitch(1000)
    }
    
    func playWithPitch(pitch:Float) {

        stopAllAudio()
        
        pitchNode.pitch = pitch
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    
    @IBAction func vaderButton(sender: UIButton) {
        playWithPitch(-500)
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
