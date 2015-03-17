//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Chitradip Mandal on 3/16/15.
//  Copyright (c) 2015 Chitradip Mandal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordPress(sender: UIButton, forEvent event: UIEvent) {
        recordingLabel.hidden = false;
        stopButton.hidden = false;

    }

    @IBAction func stopPress(sender: UIButton) {
        recordingLabel.hidden = true;
    }
}

