//
//  ViewController.swift
//  blackjack
//
//  Created by Elaine Chang on 2/15/15.
//  Copyright (c) 2015 Elaine Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var x:Int = 3
    var money:Int = 100
    var imoney:Int = 0
    var cardRank = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    var cardP = ["♠", "♥", "♦", "♣" ]
    var ex = [Int]()
    var h:Int = 2
    var h2:Int = 2
    var na = [Int]()
    var na2 = [Int]()
    var pa = [Int]()
    var pa2 = [Int]()
    var s1:String = ""
    var s2:String = ""
    var ram:Int = 0
    var num:Int = 0
    var p:Int = 0
    var sum:Int = 0
    var sumplayer:Int = 0
    var sumdealer:Int = 0
    var counter:Int = 0
    var countA:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        left.text = String(money)
        for k in 0..<52{
            ex += [1]
        }
    }
    
    func startnew() {
        
        h = 2
        h2 = 2
        na = [Int]()
        na2 = [Int]()
        pa = [Int]()
        pa2 = [Int]()
        s1 = ""
        s2 = ""
        
        for i in 0..<2 {
            ram = Int(rand()%52)
            while ex[ram] == 0{
                ram = Int(rand()%52)
                if ram == 0{
                    ram = 52
                }
            }
            ex[ram] = 0
            num = ram % 13
            if num == 0{
                num = 13
            }
            p = ram / 13
            na += [num]
            pa += [p]
            //println(na[i])
        }
        
        for i in 0..<2 {
            ram = Int(rand()%52)
            while ex[ram] == 0{
                ram = Int(rand()%52)
                if ram == 0{
                    ram = 52
                }
            }
            ex[ram] = 0
            num = ram % 13
            if num == 0{
                num = 13
            }
            p = ram / 13
            na2 += [num]
            pa2 += [p]
        }
        
        s1 = "\n Dealer: \(cardP[pa2[0]]) \(na2[0])" //\(cardP[pa2[1]]) \(na2[1])
        s2 = "\n Player: \(cardP[pa[0]]) \(na[0]) \(cardP[pa[1]]) \(na[1])"
        
        Output.text = s1 + s2
        
        countSum(na, size: h - 1);
        sumplayer = sum
        countSum(na2, size: h2-1)
        sumdealer = sum
    }
    
    func endofgame() {
        sumplayer = 0
        counter = counter + 1
        if counter > 4 {
            println("RESET!")
            counter = 1
            ex = [Int]()
            for k in 0..<52{
                ex += [1]
            }
            Output.text = "Please input the money"
            //startnew()
        } else {
            Output.text = "Please input the money"
            //startnew()
        }
        //println(counter)
    }
    
    func countSum (array: [Int], size: Int) -> Int {
        countA = 0
        sum = 0
        var index: Int
        for index = 0; index <= size; ++index {
            //println("\(na[index])")
            if array[index] == 11 || array[index] == 12 || array[index] == 13 {
                sum = sum + 10
            } else {
                if array[index] == 1 {
                    countA++
                } else {
                    sum = sum + array[index]
                }
            }
        }
        switch countA {
        case 1:
            if sum + 11 < 21 {
                sum = sum + 11
            } else {
                sum = sum + 1
            }
        case 2:
            if sum + 12 < 21 {
                sum = sum + 12
            } else {
                sum = sum + 2
            }
        case 3:
            if sum + 13 < 21 {
                sum = sum + 13
            } else {
                sum = sum + 3
            }
        case 4:
            if sum + 14 < 21 {
                sum = sum + 14
            } else {
                sum = sum + 4
            }
        default: sum = sum + 0
        }
        return sum
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var left: UILabel!
    @IBOutlet weak var bet: UILabel!
    @IBOutlet weak var outputm: UILabel!
    @IBOutlet weak var Output: UILabel!
    @IBOutlet weak var Input: UITextField!
    @IBAction func Enter(sender: AnyObject) {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        //.text = Input.text
        if money < 0 {
            
            Output.text = "You have no money!"
            
        }
        
        if Input.text == "H"{
            
            ram = Int(rand()%52)
            while ex[ram] == 0{
                ram = Int(rand()%52)
                if ram == 0{
                        ram = 52
                }
            }
            ex[ram] = 0
            num = ram%13
            if num == 0{
                num = 13
            }
          //  if num == 0{
          //      num = 13
          //  }
            p = ram/13
            na += [num]
            pa += [p]
            s2 += " \(cardP[pa[h]]) \(na[h])"
            
            countSum(na, size: h);
            sumplayer = sum
            //println("PlayerSum \(sumplayer)")
            
            if sum > 21{
                Output.text = s1 + s2 + " Bust! You lose!"
                bet.text = ""
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    
                   /* Output.text = "Please input the money"
                    bet.text = Input.text
                    money = money - imoney
                    left.text = String(money)*/


                    self.endofgame()
                }
             }
            else{
                Output.text = s1 + s2
            }
            h = h+1
            
        }
            
        else if Input.text == "S"{

            countSum(na2, size: h2-1)
             while sumdealer < sumplayer && sumdealer < 17 {
                ram = Int(rand()%52)
                while ex[ram] == 0{
                    ram = Int(rand()%52)
                    if ram == 0{
                        ram = 52
                    }
                }
                ex[ram] = 0
                num = ram%13
                if num == 0{
                    num = 13
                }
            //    if num == 0{
            //        num = 13
            //    }
                p = ram/13
                na2 += [num]
                pa2 += [p]
                countSum(na2, size: h2-1)
                sumdealer = sum
                h2 = h2 + 1
            }
            s1 += "\(cardP[pa2[1]]) \(na2[1])"
            var index: Int
            for index = 2; index < h2 - 1; ++index {
                s1 += " \(cardP[pa2[index]]) \(na2[index])"
            
            }
            
            println("DealerSum \(sumdealer)")
            println("PlayerSum \(sumplayer)")
            
            if sumdealer > 21 {
                    Output.text = s1 + "Bust!" + s2 + " You win!"
                    money = money + imoney*2
                    left.text = String(money)
                    bet.text = ""
                    dispatch_after(delayTime, dispatch_get_main_queue()) {
                  
                    self.endofgame()
                }
                
            }  else if sumdealer > sumplayer {
                
                Output.text = s1 + s2 + " You lose!"
                bet.text = ""
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                  
                    self.endofgame()
                }
                
            } else if sumdealer == sumplayer {
                
                money = money + imoney
                left.text = String(money)
                bet.text = ""
                Output.text = s1 + s2 + " Draw!"
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    
                    self.endofgame()
                }
            }
            else {
                money = money + imoney*2
                left.text = String(money)
                bet.text = ""
                Output.text = s1 + s2 + " You win!"
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    
                    self.endofgame()
                }
            }
        }
            
        else if Input.text == "N"{
            
            /*counter = 0
            Output.text = "Please input the money"*/
            money = 100
            counter = 1
            left.text = String(money)
            bet.text = ""
            ex = [Int]()
            for k in 0..<52{
                ex += [1]
            }
            
            endofgame()
            
            
        } else{
                //imoney = Input.text.toInt()!
            if (Input.text.toInt() != nil) {
                println("TRUE")
                imoney = Input.text.toInt()!
                if imoney > money{
                    Output.text = "You do not have enough money!"
                    
                    
                } else if Input.text == "0"{
                    Output.text = "Cannot input 0! \n Please input the money"
                    
                } else{
                    Output.text = "Please input the money"
                    bet.text = Input.text
                    money = money - imoney
                    left.text = String(money)
                    startnew()
                    //counter = 0
                
                
                
                
                }

            
            } else{
                println("FALSE")
                Output.text = "Please input integer!"

            
            }
            
            
            
            
            
            
        
        
        
        }
        
        
        
        
    }


}

