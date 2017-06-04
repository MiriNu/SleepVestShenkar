//
//  ControlsTableViewController.swift
//  SleepVestShenkarIosApp
//
//  Created by Marin postma on 04/06/2017.
//  Copyright © 2017 Marin postma. All rights reserved.
//

import UIKit


class ControlsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, SleepRoutineDelegate {

    @IBOutlet weak var wakeUpSwitch: UISwitch!
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var ledLevelslider: UISlider!
    @IBOutlet weak var selectedSleepLabel: UILabel!
    @IBOutlet weak var sleepPickerView: UIPickerView!
    

    let sleepRoutine = SleepRoutine()
    
    let pickerData: [SleepType] = [SleepType.biphasic, SleepType.monophasic, SleepType.dymaxion, SleepType.everyman, SleepType.uberman]
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepPickerView.delegate = self
        sleepPickerView.dataSource = self
        sleepRoutine.delegate = self
        sleepRoutine.datafetch()
        sleepPickerView.isHidden = true
        timer = Timer(timeInterval: 2, repeats: true, block: { _ in //fetch data every 2 sec and update UI
            self.sleepRoutine.datafetch()
        })
        
        print(mark)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate() //invalidate the timer before view disappear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: pickerview delegate and datasource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sleepRoutine.sleepType = pickerData[row]
        sleepRoutine.wakeUp = false
        sleepRoutine.sleep = false
        sleepRoutine.ledLevel = 0
        selectedSleepLabel.text = pickerData[row].rawValue
        sleepPickerView.isHidden = true
        sleepRoutine.sendData()
    }
    
    // MARK: SleepRoutine delegate method :
    
    func updateLabels() {
        wakeUpSwitch.isOn = sleepRoutine.wakeUp
        sleepSwitch.isOn = sleepRoutine.sleep
        ledLevelslider.setValue(Float(sleepRoutine.ledLevel), animated: true)
        selectedSleepLabel.text = sleepRoutine.sleepType.rawValue
    }
    
    // MARK: tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 2 {
            sleepPickerView.isHidden = false
            tableView.deselectRow(at: indexPath, animated: true)
        
        }
    }
    
    
    //MARK: UI methods
    
    @IBAction func getSliderValue(_ sender: UISlider) {
        sleepRoutine.ledLevel = Int(ledLevelslider.value)
        sleepRoutine.sleepType = .test
        sleepRoutine.sendData()
    }
    
    @IBAction func wakeUpcahnged(_ sender: UISwitch) {
        sleepRoutine.wakeUp = wakeUpSwitch.isOn
        sleepRoutine.sleepType = .test
        sleepRoutine.sendData()
    }
    
    @IBAction func sleepChanged(_ sender: UISwitch) {
        sleepRoutine.sleep = sleepSwitch.isOn
        sleepRoutine.sleepType = .test
        sleepRoutine.sendData()
    }
}
