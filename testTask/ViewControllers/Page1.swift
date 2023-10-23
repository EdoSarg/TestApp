//
//  Page1.swift
//  testTask
//
//  Created by Edgar Sargsyan on 19.10.23.
//

import UIKit

class Page1: UIViewController {

    @IBOutlet weak var loading: UIProgressView!
    @IBOutlet weak var numberLoading: UILabel!
    
    var timer: Timer?
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            self.count += 1
            self.numberLoading.text = "\(self.count) %"
            self.loading.progress = Float(self.count) / 100.0
            
            if self.count == 100 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let page2 = storyboard.instantiateViewController(withIdentifier: "CustomTabBarViewController") as? CustomTabBarViewController {
                        self.navigationController?.pushViewController(page2, animated: true)
                    }
                }
            }
        }
    }



    
    

