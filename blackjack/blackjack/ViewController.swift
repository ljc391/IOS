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
    var h:Int = 4
    var na = [Int]()
    var na2 = [Int]()
    var pa = [Int]()
    var s:String = ""
    var s1:String = ""
    var s2:String = ""
    var ram:Int = 0
    var num:Int = 0
    var p:Int = 0
    var sum:Int = 0
    var sum2:Int = 0
    var counter:Int = 0
    var pbust:Bool = false
    var dbust:Bool = false
    var naa:Bool = false
    var nab:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for k in 0..<52{
            ex += [1]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var bet: UILabel!
    @IBOutlet weak var outputm: UILabel!
    @IBOutlet weak var Output: UILabel!
    @IBOutlet weak var Input: UITextField!
    @IBAction func Enter(sender: AnyObject) {
        
             if money < 0 {
                Output.text = "You have no money!"
                exit(0)
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
            if num == 0{
                num = 13
            }
            p = ram/13
            na += [num]
            pa += [p]
            s2 += "\(cardP[pa[h]]) \(na[h])"
            if na[h] == 11 || na[h] == 12 || na[h] == 13 {
                sum = sum + 10
            }
            else {
                sum = sum + na[h]
            }
            println("H SUM \(sum)")
            if sum > 21{
                Output.text = s1 + s2 + "bust! "
                pbust = true
             }
            else{
                Output.text = s1 + s2
            }
            h = h+1
            
            
        }
        else if Input.text == "S"{
            
        
            
            while sum2 < sum && sum2 < 17 {
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
                p = ram/13
                na += [num]
                pa += [p]
                s1 += "\(cardP[pa[h]]) \(na[h])"
                if na[h] == 11 || na[h] == 12 || na[h] == 13 {
                    sum2 = sum2 + 10
                }
                else {
                    sum2 = sum2 + na[h]
                }
                h = h + 1
                
                println("S SUM \(sum2)")
             }
            
            if sum2 > 21 {
                if pbust{
                    Output.text = s1 + "Bust!" + s2 + " Draw!"
                    println("\(s1) Bust! \(s2) Draw!")
                }
                else{
                    Output.text = s1 + "Bust!" + s2 + " You win!"
                    println("\(s1) Bust! \(s2) You win!")
                }
                sum = 0
                sum2 = 0
                counter = counter + 1
            } else if pbust {
                Output.text = s1 + s2 + " You lose!"
                println("\(s1) \(s2) You lose!")
                sum = 0
                sum2 = 0
                counter = counter + 1
                pbust = false
                
            } else if sum2 > sum {
                Output.text = s1 + s2 + " You lose!"
                println("\(s1) \(s2) You lose!")
                sum = 0
                sum2 = 0
                counter = counter + 1
            
            
            } else if sum2 == sum{
                Output.text = s1 + s2 + " Draw!"
                println("\(s1) \(s2) Draw!")
                sum = 0
                sum2 = 0
                counter = counter + 1
            
            
            }
            else {
                Output.text = s1 + s2 + " You win!"
                println("\(s1) \(s2) You win!")
                sum = 0
                sum2 = 0
                counter = counter + 1
            
             }
            
            
            
            
            }
        else if Input.text == "N"{
            if counter < 5{
                for i in 0..<4{
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
                    p = ram/13
                    na += [num]
                    pa += [p]
                }
                s1 = "DECK:\(cardP[pa[h]]) \(na[h]) \(cardP[pa[h+1]]) \(na[h+1])"
                s2 = "Player: \(cardP[pa[h+2]]) \(na[h+2]) \(cardP[pa[h+3]]) \(na[h+3])"
                
                if na[h+2] == 11 || na[h+2] == 12 || na[h+2] == 13 {
                    sum = sum + 10
                }
                else {
                    sum = sum + na[h+2]
                }
                
                if na[h+3] == 11 || na[h+3] == 12 || na[h+3] == 13 {
                    sum = sum + 10
                }
                else {
                    sum = sum + na[h+3]
                }
                sum2 = na[h]+na[h+1]
                
                if sum > 21{
                    Output.text = s1 + s2 + "bust! "
                    pbust = true
                }
                else{
                    Output.text = s1 + s2
                }
                
            }
            else{
                for k in 0..<52{
                    ex += [1]
                }
                for i in 0..<4{
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
                    p = ram/13
                    na += [num]
                    pa += [p]
                }
                s1 = "DECK:\(cardP[pa[0]]) \(na[0]) \(cardP[pa[1]]) \(na[1])"
                s2 = "Player: \(cardP[pa[2]]) \(na[2]) \(cardP[pa[3]]) \(na[3])"
                
                if na[2] == 11 || na[2] == 12 || na[2] == 13 {
                    sum = sum + 10
                }
                else {
                    sum = sum + na[2]
                }
                
                if na[3] == 11 || na[3] == 12 || na[3] == 13 {
                    sum = sum + 10
                }
                else {
                    sum = sum + na[3]
                }
                sum2 = na[0]+na[1]
                
                if sum > 21{
                    Output.text = s1 + s2 + "bust! "
                    pbust = true
                }
                else{
                    Output.text = s1 + s2
                }
                counter = 0

            }
            
            
            
            
        } else {
            imoney = Input.text.toInt()!
            println(imoney)
            bet.text = Input.text
            for i in 0..<4{
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
                p = ram/13
                na += [num]
                pa += [p]
                }
            s1 = "DECK:\(cardP[pa[0]]) \(na[0]) \(cardP[pa[1]]) \(na[1])"
            s2 = "Player: \(cardP[pa[2]]) \(na[2]) \(cardP[pa[3]]) \(na[3])"
            
            if na[2] == 1{
                naa = true
            }
            if na[3] == 1{
                nab = true
            }
            
            
            if na[2] == 11 || na[2] == 12 || na[2] == 13 {
                sum = sum + 10
            }
            else {
                sum = sum + na[2]
            }
            
            
            
            if na[3] == 11 || na[3] == 12 || na[3] == 13 {
                sum = sum + 10
            }
            else {
                sum = sum + na[3]
            }
             sum2 = na[0]+na[1]
            
            
            if sum > 21{
                Output.text = s1 + s2 + "bust! "
                pbust = true
            }
            else{
                Output.text = s1 + s2
            }
            counter = 0
        }
        
        
            if Input.text == "E"
                { exit(0)}
        
        
    }


}

