//
//  PlayViewController.swift
//  BlackJack2
//
//  Created by Elaine Chang on 2/26/15.
//  Copyright (c) 2015 Elaine Chang. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UIActionSheetDelegate {
    
    var numofplayers:Int = 0
    var numofcards:Int32 = 0
    var used = [Int]()
    var players = [player]()
    var adealer = dealer()
    var randomcard:Int = 0
    var randomcardnumber:Int = 0
    var cardnumber:Int = 0
    var cardsuit:Int = 0
    var suit = [ "♣", "♦", "♥", "♠"]
    var counter:Int = 0
    var currentplayer:Int = 0
    var endcase:Int = 0
    var loseplayer = [String]()
    var resultofgame:String = ""
    var Pcards = [UIImageView]()
    var Dcards = [UIImageView]()
    var currentcard:Int = 0
    

    @IBOutlet weak var BetOutlet: UIButton!
    @IBOutlet weak var HitOutlet: UIButton!
    @IBOutlet weak var StandOutlet: UIButton!
    @IBOutlet weak var OKOutlet: UIButton!
    
    @IBOutlet weak var Playernum: UILabel!
    @IBOutlet weak var Imoney: UILabel!
    @IBOutlet weak var Ibet: UILabel! 
    @IBOutlet weak var WorL: UILabel!
    @IBOutlet weak var Result: UILabel!
    
    @IBOutlet weak var Dcard1: UIImageView!
    @IBOutlet weak var Dcard2: UIImageView!
    @IBOutlet weak var Dcard3: UIImageView!
    @IBOutlet weak var Dcard4: UIImageView!
    @IBOutlet weak var Dcard5: UIImageView!
    @IBOutlet weak var Pcard1: UIImageView!
    @IBOutlet weak var Pcard2: UIImageView!
    @IBOutlet weak var Pcard3: UIImageView!
    @IBOutlet weak var Pcard4: UIImageView!
    @IBOutlet weak var Pcard5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myData = Singleton.sharedInstance
        numofcards = Int32(myData.numofdecks.toInt()!) * 52
        numofplayers = myData.numofplayers.toInt()!
        for i in 0..<numofcards {
            used += [1]
        }
        Pcards = [Pcard1, Pcard2, Pcard3, Pcard4, Pcard5]
        Dcards = [Dcard1, Dcard2, Dcard3, Dcard4, Dcard5]
        newgame()
        println("\(players[currentplayer].playername), Please place bet")
        Playernum.text = ("\(players[currentplayer].playername), Please place bet")
        BetOutlet.hidden = false
        HitOutlet.hidden = true
        StandOutlet.hidden = true
        OKOutlet.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionSheet(myActionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int){
        BetOutlet.hidden = true
        HitOutlet.hidden = false
        StandOutlet.hidden = false
        OKOutlet.hidden = true
         if myActionSheet.buttonTitleAtIndex(buttonIndex) == "ALL IN" {
            players[currentplayer].bet = players[currentplayer].money
            Ibet.text = String(players[currentplayer].money)
            players[currentplayer].money = 0
            Imoney.text = "0"
        } else {
            players[currentplayer].bet = myActionSheet.buttonTitleAtIndex(buttonIndex).toInt()!
            Ibet.text = myActionSheet.buttonTitleAtIndex(buttonIndex)
            players[currentplayer].money = players[currentplayer].money - players[currentplayer].bet
            Imoney.text = String(players[currentplayer].money)
        }
    }
    
    func showOptions() {
        let actionSheet = UIActionSheet(title: "Plays Bets", delegate: self, cancelButtonTitle:nil, destructiveButtonTitle: nil, otherButtonTitles: "5", "10", "15", "20", "ALL IN")
        actionSheet.showInView(self.view)
    }
    
    func newgame () {
        var j:Int = 0
        while j < numofplayers {
            //println(j)
            players.append(player())
            players[j].money = 100
            Imoney.text = "100"
            players[j].playername = "Player" + String(j+1)
            j++
        }
        
        dealcards()
        
        var s = [String]()
        var s2 = [String]()
        s.append("Dealer: \(suit[adealer.suit[0]]) \(adealer.number[0])")  //\(suit[pa2[1]]) \(na2[1])
        Dcard1.image = GetImage(adealer.suit[0], n: adealer.number[0])
        Dcard2.image = GetImage(4,n: 0)
        //Dcard3.image = GetImage(4,n: 0)
        //Dcard4.image = GetImage(4,n: 0)
        //Dcard5.image = GetImage(4,n: 0)
        // s1 += s[0]
        for i in 0..<numofplayers {
            s.append("\n \(players[i].playername): \(suit[players[i].suit[0]]) \(players[i].number[0])  \(suit[players[i].suit[1]]) \(players[i].number[1])")
        }
        Pcards[0].image = GetImage(players[currentplayer].suit[0], n: players[currentplayer].number[0])
        Pcards[1].image = GetImage(players[currentplayer].suit[1], n: players[currentplayer].number[1])
        //Pcards[2].image = GetImage(4,n: 0)
        //Pcards[3].image = GetImage(4,n: 0)
        //Pcards[4].image = GetImage(4,n: 0)
        for i in 0..<numofplayers+1{
            s2.append(s[i])
        }
        println(s2)
        
        
    }
    
    func dealcards() {
        
        for i in 0..<numofplayers {
            for j in 0..<2 {
                randomcard = Int(rand()%numofcards)
                randomcardnumber = randomcard%52
                while used[randomcard] == 0{
                    randomcard = Int(rand()%numofcards)
                    randomcardnumber = randomcard%52
                    if randomcard == 0{
                        randomcard = Int(numofcards)
                    }
                }
                used[randomcard] = 0
                cardnumber = randomcardnumber % 13
                if cardnumber == 0{
                    cardnumber = 13
                }
                cardsuit = randomcardnumber / 13
                players[i].number += [cardnumber]
                players[i].suit += [cardsuit]
                players[i].numberofcards = 2
            }
        }
        
        for i in 0..<2 {
            randomcard = Int(rand()%numofcards)
            randomcardnumber = randomcard%52
            while used[randomcard] == 0{
                randomcard = Int(rand()%numofcards)
                randomcardnumber = randomcard%52
                if randomcard == 0{
                    randomcard = Int(numofcards)
                }
            }
            used[randomcard] = 0
            cardnumber = randomcardnumber % 13
            if cardnumber == 0{
                cardnumber = 13
            }
            cardsuit = randomcardnumber / 13
            adealer.number += [cardnumber]
            adealer.suit += [cardsuit]
        }
        adealer.numberofcards = 2
        Dcard1.image = GetImage(adealer.suit[0], n: adealer.number[0])
        Dcard2.hidden = true
        Dcard3.hidden = true
        Dcard4.hidden = true
        Dcard5.hidden = true
        //Output.text = s1
        adealer.sum = countSum(adealer.number, size: adealer.numberofcards)
        //println(adealer.sum)
        
        for i in 0..<numofplayers{
            players[i].sum = countSum(players[i].number, size: players[i].numberofcards)
            //println(players[i].sum)
        }
    }
    func GetImage(p: Int, n: Int)->UIImage
    {   var assetName:String = ""
        if (p == 0){
            if (n == 1){
                assetName = "c1.png"
            }
            else if (n == 2){
                assetName = "c2.png"
            }
            else if (n == 3){
                assetName = "c3.png"
            }
            else if (n == 4){
                assetName = "c4.png"
            }
            else if (n == 5){
                assetName = "c5.png"
            }
            else if (n == 6){
                assetName = "c6.png"
            }
            else if (n == 7){
                assetName = "c7.png"
            }
            else if (n == 8){
                assetName = "c8.png"
            }
            else if (n == 9){
                assetName = "c9.png"
            }
            else if (n == 10){
                assetName = "c10.png"
            }
            else if (n == 11){
                assetName = "cj.png"
            }
            else if (n == 12){
                assetName = "cq.png"
            }
            else
            {
                assetName = "ck.png"
            }
            
        
        
        }
        else if (p == 1)
        {
            if (n == 1){
                assetName = "d1.png"
            }
            else if (n == 2){
                assetName = "d2.png"
            }
            else if (n == 3){
                assetName = "d3.png"
            }
            else if (n == 4){
                assetName = "d4.png"
            }
            else if (n == 5){
                assetName = "d5.png"
            }
            else if (n == 6){
                assetName = "6.png"
            }
            else if (n == 7){
                assetName = "d7.png"
            }
            else if (n == 8){
                assetName = "d8.png"
            }
            else if (n == 9){
                assetName = "d9.png"
            }
            else if (n == 10){
                assetName = "d10.png"
            }
            else if (n == 11){
                assetName = "dj.png"
            }
            else if (n == 12){
                assetName = "dq.png"
            }
            else
            {
                assetName = "dk.png"
            }
            
        }
        else if (p == 2)
        {
            
            if (n == 1){
                assetName = "h1.png"
            }
            else if (n == 2){
                assetName = "h2.png"
            }
            else if (n == 3){
                assetName = "h3.png"
            }
            else if (n == 4){
                assetName = "h4.png"
            }
            else if (n == 5){
                assetName = "h5.png"
            }
            else if (n == 6){
                assetName = "h6.png"
            }
            else if (n == 7){
                assetName = "h7.png"
            }
            else if (n == 8){
                assetName = "h8.png"
            }
            else if (n == 9){
                assetName = "h9.png"
            }
            else if (n == 10){
                assetName = "h10.png"
            }
            else if (n == 11){
                assetName = "hj.png"
            }
            else if (n == 12){
                assetName = "hq.png"
            }
            else{
                assetName = "hk.png"
            }
            
        }else if (p == 3){
            if (n == 1){
                assetName = "s1.png"
            }
            else if (n == 2){
                assetName = "s2.png"
            }
            else if (n == 3){
                assetName = "s3.png"
            }
            else if (n == 4){
                assetName = "s4.png"
            }
            else if (n == 5){
                assetName = "s5.png"
            }
            else if (n == 6){
                assetName = "s6.png"
            }
            else if (n == 7){
                assetName = "s7.png"
            }
            else if (n == 8){
                assetName = "s8.png"
            }
            else if (n == 9){
                assetName = "s9.png"
            }
            else if (n == 10){
                assetName = "s10.png"
            }
            else if (n == 11){
                assetName = "sj.png"
            }
            else if (n == 12){
                assetName = "sq.png"
            }
            else
            {
                assetName = "sk.png"
            }
        }
        else{
            assetName = "b1fv.png"
        }
        
        //Return an image constructed from what existed in my images folder based on logic above
        return UIImage(named: (assetName))!
        
    }
    
    @IBAction func Bet(sender: AnyObject) {
        showOptions()
        //players[currentplayer].bet = 10
        //players[currentplayer].money = players[currentplayer].money - players[currentplayer].bet
        //println("\(players[currentplayer].playername): \(suit[players[currentplayer].suit[0]]) \(players[currentplayer].number[0])  \(suit[players[currentplayer].suit[counter1]]) \(players[currentplayer].number[1])")
    }
    
    @IBAction func Hit(sender: AnyObject) {
        randomcard = Int(rand()%numofcards)
        randomcardnumber = randomcard%52
        while used[randomcard] == 0{
            randomcard = Int(rand()%numofcards)
            randomcardnumber = randomcard%52
            if randomcard == 0{
                randomcard = Int(numofcards)
            }
        }
        used[randomcard] = 0
        cardnumber = randomcardnumber % 13
        if cardnumber == 0{
            cardnumber = 13
        }
        cardsuit = randomcardnumber / 13
        players[currentplayer].number += [cardnumber]
        players[currentplayer].suit += [cardsuit]
        players[currentplayer].numberofcards++
        Pcards[currentcard+2].image = GetImage(players[currentplayer].suit[currentcard+2], n: players[currentplayer].number[currentcard+2])
        Pcards[currentcard+2].hidden = false
        currentcard += 1
        for i in 0..<players[currentplayer].numberofcards {
            println(players[currentplayer].number[i])
        }
        players[currentplayer].sum = countSum(players[currentplayer].number, size: players[currentplayer].numberofcards)
        //println(players[currentplayer].sum)
        if players[currentplayer].sum > 21 {
            if currentplayer + 1 == numofplayers {
                println("Bust")
                WorL.text = "Bust"
                currentcard = 0
                Playernum.text = ("\(players[currentplayer].playername), Bust!")
                endcase = 2
                BetOutlet.hidden = true
                HitOutlet.hidden = true
                StandOutlet.hidden = true
                OKOutlet.hidden = false
            } else {
                println("Bust")
                WorL.text = "Bust"
                currentcard = 0
                Playernum.text = ("\(players[currentplayer].playername), Bust")
                endcase = 1
                BetOutlet.hidden = true
                HitOutlet.hidden = true
                StandOutlet.hidden = true
                OKOutlet.hidden = false
            }
        }
        /*for i in 0..<numofplayers {
            println(players[i].playername)
        }*/
    }
    
    @IBAction func Stand(sender: AnyObject) {
        currentplayer = currentplayer + 1
        currentcard = 0
        
        if currentplayer == numofplayers {
            endcase = 2
            OK(self)
            BetOutlet.hidden = true
            HitOutlet.hidden = true
            StandOutlet.hidden = true
            OKOutlet.hidden = false
            
        } else {
            println("\(players[currentplayer].playername), Please place bet")
            Playernum.text = ("\(players[currentplayer].playername), Please place bet")
            BetOutlet.hidden = false
            HitOutlet.hidden = true
            StandOutlet.hidden = true
            OKOutlet.hidden = true
            Imoney.text = String(players[currentplayer].money)
            Ibet.text = String(players[currentplayer].bet)
            Pcards[0].image = GetImage(players[currentplayer].suit[0], n: players[currentplayer].number[0])
            Pcards[1].image = GetImage(players[currentplayer].suit[1], n: players[currentplayer].number[1])
            Pcards[2].hidden = true
            Pcards[3].hidden = true
            Pcards[4].hidden = true
            //Pcards[2].image = GetImage(4, n: 0)
            //Pcards[3].image = GetImage(4, n: 0)
            //Pcards[4].image = GetImage(4, n: 0)
            
            
            
        }
        
    }
    
    @IBAction func OK(sender: AnyObject) {
        currentcard = 0
        switch endcase {
        case 1:
            currentplayer++
            println("\(players[currentplayer].playername), Please place bet")
            Playernum.text = ("\(players[currentplayer].playername), Please place bet")
            Imoney.text = String(players[currentplayer].money)
            Ibet.text = String(players[currentplayer].bet)
            BetOutlet.hidden = false
            HitOutlet.hidden = true
            StandOutlet.hidden = true
            OKOutlet.hidden = true
            WorL.text = ""
            Pcards[0].image = GetImage(players[currentplayer].suit[0], n: players[currentplayer].number[0])
            Pcards[1].image = GetImage(players[currentplayer].suit[1], n: players[currentplayer].number[1])
            Pcards[2].hidden = true
            Pcards[3].hidden = true
            Pcards[4].hidden = true
            //Pcards[2].image = GetImage(4, n: 0)
            //Pcards[3].image = GetImage(4, n: 0)
            //Pcards[4].image = GetImage(4, n: 0)

        case 2:
            countdealer()
            winningcondition()
            resultofgame = ""
            endcase = 3
            BetOutlet.hidden = true
            HitOutlet.hidden = true
            StandOutlet.hidden = true
            OKOutlet.hidden = false
        case 3:
            endofround()
            currentplayer = 0
            if (numofplayers != 0) {
                println("\(players[currentplayer].playername), Please place bet")
                Playernum.text = ("\(players[currentplayer].playername), Please place bet")
                Imoney.text = String(players[currentplayer].money)
                Ibet.text = String(players[currentplayer].bet)
                Pcards[0].image = GetImage(players[currentplayer].suit[0], n: players[currentplayer].number[0])
                Pcards[1].image = GetImage(players[currentplayer].suit[1], n: players[currentplayer].number[1])
                Pcards[2].hidden = true
                Pcards[3].hidden = true
                Pcards[4].hidden = true
                //Pcards[2].image = GetImage(4, n: 0)
                //Pcards[3].image = GetImage(4, n: 0)
                //Pcards[4].image = GetImage(4, n: 0)
  
                
            }
            resultofgame = ""
            Result.text = resultofgame
            BetOutlet.hidden = false
            HitOutlet.hidden = true
            StandOutlet.hidden = true
            OKOutlet.hidden = true
            
        default: break
        }
    }
    
    func countdealer() {
        
        println("dealer's time")
        
        var maxsum:Int = 0
        if numofplayers-1 == 0{
            maxsum = 21
        } else{
            for i in 0..<numofplayers {
                maxsum = max(maxsum, players[currentplayer - 1].sum)
            }
        
        }
        
        if maxsum > 21 {
            maxsum = 21
        }
        
        while adealer.sum < 17 && adealer.sum < maxsum{
            println("give card")
            randomcard = Int(rand()%numofcards)
            randomcardnumber = randomcard%52
            while used[randomcard] == 0{
                randomcard = Int(rand()%numofcards)
                randomcardnumber = randomcard%52
                if randomcard == 0{
                    randomcard = Int(numofcards)
                }
            }
            used[randomcard] = 0
            cardnumber = randomcardnumber % 13
            if cardnumber == 0{
                cardnumber = 13
            }
            cardsuit = randomcardnumber / 13
            adealer.number += [cardnumber]
            adealer.suit += [cardsuit]
            adealer.numberofcards++
            adealer.sum = countSum(adealer.number, size: adealer.numberofcards)
            //countSum(ndealer.n, size:h2)
            //s[0] += " \(cardP[ndealer.p[h2-1]])\(ndealer.n[h2-1])"
            //println(s[0])
            //sumdealer = sum
            //h2 = h2 + 1
        }
        for i in 0..<adealer.numberofcards {
            println(adealer.number[i])
            Dcards[i].image = GetImage(adealer.suit[i], n: adealer.number[i])
            Dcards[i].hidden = false
        
        }
        println(adealer.sum)
    }
    
    func winningcondition() {
        println("Dealer: \(adealer.number) \n")
        if adealer.sum > 21 {
            for i in 0..<numofplayers {
                if players[i].sum <= 21 {
                    players[i].money = players[i].money + 2 * players[i].bet
                    println("\(players[i].playername): \(players[i].number) ,You Win!")
                    resultofgame += "\(players[i].playername): \(players[i].sum) You Win! \n"
                
                } else {
                    println("\(players[i].playername): \(players[i].number) ,You Lose!")
                    resultofgame += "\(players[i].playername): \(players[i].sum) You Lose! \n"
                    if players[i].money <= 0 {
                        println("You Have No Money, GoodBye!")
                        resultofgame += "\(players[i].playername) You Have No Money, GoodBye! \n"
                        loseplayer.append(players[i].playername)
                    }
                }
            }
            Result.text = resultofgame
        } else {
            for i in 0..<numofplayers {
                if players[i].sum < adealer.sum {
                    println("\(players[i].playername): \(players[i].number), You Lose! \n")
                    resultofgame += ("\(players[i].playername): \(players[i].sum) You Lose! \n")
                    if players[i].money <= 0 {
                        println("Your Have No Money, GoodBye!")
                        resultofgame += "\(players[i].playername) You Have No Money, GoodBye! \n"
                        loseplayer.append(players[i].playername)
                    }
                } else if players[i].sum == adealer.sum {
                    println("\(players[i].playername): \(players[i].number), Draw! \n")
                    resultofgame += ("\(players[i].playername): \(players[i].sum) Draw! \n")
                } else {
                    if players[i].sum > 21 {
                        println("\(players[i].playername): \(players[i].number) ,You Lose!")
                        resultofgame += ("\(players[i].playername): \(players[i].sum) You Lose! \n")
                        if players[i].money <= 0 {
                            println("Your Have No Money, GoodBye!")
                            resultofgame += "\(players[i].playername) You Have No Money, GoodBye! \n"
                            loseplayer.append(players[i].playername)
                        }
                    } else {
                        players[i].money = players[i].money + 2 * players[i].bet
                        println("\(players[i].playername): \(players[i].number) ,You Win!")
                        resultofgame += ("\(players[i].playername): \(players[i].sum) You Win!\n")
                    }
                }
                
            }
            Result.text = resultofgame
        }
    }
    
    func endofround() {
        println(loseplayer)
        for i in 0..<loseplayer.count {
            players = players.filter {$0.playername != self.loseplayer[i]}
            numofplayers = players.count
        }
        if numofplayers == 0 {
            println("EndOfGame!")
            self.performSegueWithIdentifier("ToMain", sender: self)
        }
        
        if counter > 4 {
            for i in 0..<numofcards {
                used += [1]
            }
            counter = 1
        }
        adealer.sum = 0
        adealer.numberofcards = 2
        adealer.number = [Int]()
        adealer.suit = [Int]()
        
        for i in 0..<numofplayers{
            players[i].sum = 0
            players[i].numberofcards = 2
            players[i].number = [Int]()
            players[i].suit = [Int]()
            Pcards[i].image = GetImage(4,n: 0)
        }
        Pcards[2].hidden = true
        Pcards[3].hidden = true
        Pcards[4].hidden = true
        
        currentplayer = 0
        currentcard = 0
        counter++
        
        dealcards()
    }
    
    func countSum (array: [Int], size: Int) -> Int {
        var sum:Int = 0
        var countA:Int = 0
        var index: Int
        for index = 0; index < size; ++index {
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}