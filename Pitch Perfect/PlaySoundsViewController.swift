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

    var recieveRecordedAudio:RecordingData!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile:AVAudioFile!
    var pitchNode:AVAudioUnitTimePitch!
    var reverbNode:AVAudioUnitReverb!
    var echoPlayers = [AVAudioPlayer]()

    var audioEngineReverb:AVAudioEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup audio engine
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        pitchNode = AVAudioUnitTimePitch()
        
        reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        
        
        audioFile = AVAudioFile(forReading: recieveRecordedAudio.filePath, error: nil)
        audioEngine.attachNode(pitchNode)
        audioEngine.attachNode(reverbNode)
        audioEngine.connect(audioPlayerNode, to: reverbNode, format: audioFile.processingFormat)
        audioEngine.connect(reverbNode, to: pitchNode, format: audioFile.processingFormat)
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
    
    @IBAction func snailButton(sender: UIButton) {
        playWithRate(0.5)
    }
    
    @IBAction func chipmunkButton(sender: UIButton) {
        playWithPitch(1000)
    }
    @IBAction func vaderButton(sender: UIButton) {
        playWithPitch(-500)
    }
    @IBAction func echoPress(sender: AnyObject) {
        playEcho(4, delayMs: 500, attenuation: 0.1)
    }
    
    @IBAction func reverbPress(sender: AnyObject) {
        playWithReverb()
    }
    
    @IBAction func stopButton(sender: UIButton) {
      stopAllAudio()
    }
    
    func stopAllAudio() {
        
        audioPlayerNode.stop()
        audioEngine.stop()
        audioPlayerNode.reset()
        
        for player in echoPlayers {
            player.stop()
        }
        
    }
    
    func playWithRate(rate: Float) {
        stopAllAudio()
        reverbNode.wetDryMix = 0
        pitchNode.pitch = 1
        pitchNode.rate = rate
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    func playWithPitch(pitch:Float) {

        stopAllAudio()
        reverbNode.wetDryMix = 0
        pitchNode.pitch = pitch
        pitchNode.rate = 1
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    func playWithReverb() {
        
        stopAllAudio()
        reverbNode.wetDryMix = 20
        pitchNode.pitch = 1
        pitchNode.rate = 1
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }


    func playEcho(repeat: Int, delayMs: Double, attenuation:Float) {
        stopAllAudio()
        
        echoPlayers.removeAll(keepCapacity: true)
        
        for i in 1...repeat {
            echoPlayers.append(AVAudioPlayer(contentsOfURL: recieveRecordedAudio.filePath, error: nil))
        }
        
        print(echoPlayers.endIndex)
        var volume:Float = 1.0
        for i in 0...(repeat-1) {
            //echoPlayers[i] = AVAudioPlayer()
            echoPlayers[i].volume = volume
            var currDelay:NSTimeInterval = (delayMs*Double(i))/1000
            echoPlayers[i].playAtTime(echoPlayers[i].deviceCurrentTime + currDelay)
            volume = volume * attenuation
        }
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
