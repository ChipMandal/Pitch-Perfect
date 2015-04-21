//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Chitradip Mandal on 3/16/15.
//  Copyright (c) 2015 Chitradip Mandal. All rights reserved.
//

import UIKit
import AVFoundation

enum States {
    case ReadyToRecord
    case Recording
    case Paused
}

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    let STOP_RECORDING_SEGUE = "stopRecording"
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!

    func updateUIBasedOnState(state:States) {
        switch (state) {
        case .ReadyToRecord:
            stopButton.hidden = true;
           
            recordButton.enabled = true;
            recordButton.hidden = false;
            
            pauseButton.hidden = true;
            resumeButton.hidden = true;
            
            recordingLabel.hidden = false;
            recordingLabel.text = "Tap to Record"
        case .Paused:
            stopButton.hidden = false;
            
            recordButton.hidden = true;
            
            pauseButton.hidden = true;
            
            resumeButton.enabled = true;
            resumeButton.hidden = false;
            
            recordingLabel.text = "Tap to Resume"
        case .Recording:
            stopButton.hidden = false;
            
            recordButton.hidden = true;
            
            pauseButton.enabled = true;
            pauseButton.hidden = false;
            resumeButton.hidden = true;
            
            recordingLabel.text = "Recording"
            
            
        }
    }
    
    @IBAction func resumePress(sender: AnyObject) {
        updateUIBasedOnState(States.Recording)
        audioRecorder.record()
    }
    
    @IBAction func pausePress(sender: AnyObject) {
        updateUIBasedOnState(States.Paused)
        audioRecorder.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        updateUIBasedOnState(States.ReadyToRecord)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func recordPress(sender: UIButton, forEvent event: UIEvent) {
        
        updateUIBasedOnState(States.Recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        var recordingData: RecordingData = RecordingData(fileName: recorder.url.lastPathComponent!, filePath: recorder.url)
        if ( flag ) {
            performSegueWithIdentifier(STOP_RECORDING_SEGUE, sender: recordingData)
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == STOP_RECORDING_SEGUE) {
            let playSoundsViewController:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordingData
            playSoundsViewController.recieveRecordedAudio = data
        }
    }

    @IBAction func stopPress(sender: UIButton) {
        recordingLabel.hidden = true;
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

