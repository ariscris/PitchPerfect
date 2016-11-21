//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Villareal, Aris on 11/10/16.
//  Copyright © 2016 Villareal, Aris. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    let recordLabelPressToRecord = "Press to Record"
    let recordLabelInProgress = "Recording in progress"
    
    override func viewWillAppear(_ animated: Bool) {
        setUIState(isRecording:false, recordLabelText:recordLabelPressToRecord)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        setUIState(isRecording:true, recordLabelText:recordLabelInProgress)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        setUIState(isRecording:true, recordLabelText:recordLabelPressToRecord)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    internal func setUIState(isRecording:Bool, recordLabelText:String)
    {
        recordLabel.text = recordLabelText
        stopButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully success: Bool) {
        if success {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("couldn't record")
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

