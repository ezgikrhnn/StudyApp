//
//  CounterPage.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 9.12.2023.
//

import UIKit

class CounterPage: UIViewController {
    
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var imageViewCircle: UIImageView!
    @IBOutlet weak var resetButton: UIButton!
    
    var veri: SetItem?
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var targetTime: Int = 0
    var timeString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veriyiStringeCevir()
        print("target time budur: \(targetTime)")
        
        
        
    }
    
    @IBAction func startStopTapped(_ sender: Any) {
        
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        else
        {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func ButtonReset(_ sender: Any) {
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.labelTime.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        labelTime.text = timeString
        if targetTime == count {
            timer.invalidate()
           startShakingLabel()
        }
        
        
    }
    
    func startShakingLabel() {
           // Titreme animasyonunu oluştur
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = Float.infinity
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: labelTime.center.x - 5, y: labelTime.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: labelTime.center.x + 5, y: labelTime.center.y))

           // Animasyonu etikete ekle
        labelTime.layer.add(shakeAnimation, forKey: "position")
           // Etiketin metni kırmızı renge ayarla
        labelTime.textColor = UIColor.red
        imageViewCircle.tintColor = .black
        imageViewCircle.layer.opacity = 0.2
        
        startStopButton.tintColor = .black
        startStopButton.layer.opacity = 0.3
        resetButton.tintColor = .black
        resetButton.layer.opacity = 0.3
       }
    
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
    
        return timeString
    }
    
    func veriyiStringeCevir(){
        
        if let v = veri, let setTime = v.setTime {
            // Saat ifadesini "HH:mm" formatında ayrıştırma
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            if let date = formatter.date(from: setTime) {
                // "HH:mm:ss" formatına dönüştürme
                
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute], from: date)
                            
                let hoursInSeconds = components.hour! * 3600
                let minutesInSeconds = components.minute! * 60
                            
                targetTime = hoursInSeconds + minutesInSeconds
                            
                            // Zamanı saniye cinsinden string olarak gösterme
                labelTime.text = makeTimeString(hours: components.hour!, minutes: components.minute!, seconds: 0)
                            
                
            } else {
                // Hata durumu
                print("Saat ifadesi ayrıştırılamadı.")
            }
            
        }
    }
    
}



/** if let v = veri, let setTime = v.setTime {
     // Saat ifadesini "HH:mm" formatında ayrıştırma
     let formatter = DateFormatter()
     formatter.dateFormat = "HH:mm"
     
     if let date = formatter.date(from: setTime) {
         // "HH:mm:ss" formatına dönüştürme
         
         formatter.dateFormat = "HH:mm:ss"
         let formattedTime = formatter.string(from: date)
         labelTime?.text = formattedTime
         
         
     } else {
         // Hata durumu
         print("Saat ifadesi ayrıştırılamadı.")
     }
     
 }**/


/**import UIKit
 
 class CounterPage: UIViewController {
     
     @IBOutlet weak var labelTime: UILabel!
     
     var veri: SetItem?
     var seconds = 60
     var minutes = 60
     var timer = Timer()
     var isTimerRunning = false  //this will be used to make sure only one timer is created at a time
     var stopTapped = false
     
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     
     @IBAction func ButtonStart(_ sender: Any) {
         if isTimerRunning == false {
                  runTimer()
             }
     }
     
     @IBAction func ButtonStop(_ sender: Any) {
         if self.stopTapped == false {
             timer.invalidate()
             self.stopTapped = true
         }else {
             runTimer()
             self.stopTapped = false
         }
     }
     
     @IBAction func ButtonReset(_ sender: Any) {
         timer.invalidate()
         seconds = 0
         labelTime.text = timeString(time: TimeInterval(seconds))
         isTimerRunning = false
     }
     
     
     func runTimer(){
         timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(CounterPage.updateTimer)), userInfo: nil, repeats: true)
     }
     
     @objc func updateTimer(){
         if seconds < 1 {
                  timer.invalidate()
                  //Send alert to indicate "time's up!"
             } else {
                  seconds -= 1
                  labelTime.text = timeString(time: TimeInterval(seconds))
             }
     }
     
     func timeString(time: TimeInterval) -> String {
         let hours = Int(time) / 3600
         let minutes = Int(time) / 60 % 60
         let seconds = Int(time) % 60
         
         return String(format: "%02i:%02i:%02i",hours,minutes,seconds)
     }
     
 }
*/

