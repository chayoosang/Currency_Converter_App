//
//  TabBarController.swift
//  CurrencyConverterApp
//
//  Created by 유상 on 2023/01/14.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.items?[0].title = "Picker"
        self.tabBar.items?[0].image = UIImage(systemName: "filemenu.and.selection")
        
        self.tabBar.items?[1].title = "Table"
        self.tabBar.items?[1].image = UIImage(systemName: "list.bullet")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
