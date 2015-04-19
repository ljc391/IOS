//
//  DetailViewController.swift
//  PolyNewsReader
//
//  Created by Ardis Kadiu on 4/7/15.
//  Copyright (c) 2015 Spark451. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailItem:AnyObject?
    var titleItem:AnyObject?
    var imageItem:AnyObject?
    
    @IBAction func background(sender: AnyObject) {
        self
        
        
        
    }
    @IBOutlet weak var Bg: UIButton!
    @IBOutlet weak var LabelTitle: UILabel!
    @IBOutlet weak var ImageP: UIImageView!
    @IBOutlet weak var LabelDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // self.navigationItem.rightBarButtonItem = self.
 //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    override func viewDidAppear(animated: Bool) {
        if let detail:AnyObject = self.detailItem{
            LabelDetail.text = detail.description
            LabelTitle.text = titleItem?.description
            
            if  let data = NSData(contentsOfURL: imageItem! as NSURL) {
                ImageP.image = UIImage(data: data)
            }

        }// Dispose of any resources that can be recreated.
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
