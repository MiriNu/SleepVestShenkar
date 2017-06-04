//
//  mainViewController.swift
//  SleepVestShenkarIosApp
//
//  Created by Marin postma on 04/06/2017.
//  Copyright © 2017 Marin postma. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    var sleepRoutine: SleepRoutine!

    @IBOutlet weak var test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       let controller = self.tabBarController as! tabbarViewController
        sleepRoutine = controller.sleepRoutine
        // Do any additional setup after loading the view.
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         test.text = String(sleepRoutine.ledLevel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
