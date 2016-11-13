//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Villareal, Aris on 11/10/16.
//  Copyright © 2016 Villareal, Aris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("got it")
        recordingLabel.text = "Recording in progress"
    }

    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Press to Record"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RecordButton.isEnabled = true
    }
}

