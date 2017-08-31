//
//  ImageViewController.swift
//  CassiniRedo
//
//  Created by Monika on 2017-08-25.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var RetryBtn: UIButton!
    
    var countTries = 0
    let maxRetries = 3
    
    @IBAction func RetryButton(_ sender: UIButton) {
        //Thread.sleep(forTimeInterval: 5)
        countTries += 1
        if (countTries) < maxRetries
        {
            scrollView.isHidden = true
            RetryBtn.isHidden = true
            ActivityIndicator.isHidden = false
            fetchImageAsync()
        }
        else
        {
            RetryBtn.isEnabled = false
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView?.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.05
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var sampleUrl = "https://triosdevelopers.com/~M.Orlinski/WF/images/image6.jpg"
    
    var imageURL: NSURL? {
        didSet {
            image = nil
            fetchImage()
        }
    }
    private func fetchImage() {
        if let url = imageURL {
            if let imageData = NSData(contentsOf: url as URL){
                image = UIImage(data: imageData as Data)
                scrollView.isHidden = false
                RetryBtn.isHidden = true
                ActivityIndicator.isHidden = true
                ActivityIndicator.startAnimating()
            }
            else {
                print("Could not connect to the internet, defaulting to offline image.")
                
                //Dealing with an impossibly small resolution
                //image = UIImage(named: "OfflineImage")
                //scrollView?.contentSize = CGSize(width: 1000, height: 1000)
                //scrollView.backgroundColor = UIColor.black
                
                //bypass the following logic.
                
                imageView.image = UIImage(named: "OfflineImage")
                imageView.sizeToFit()
                scrollView?.contentSize = imageView.frame.size
                
                scrollView.isHidden = true
                RetryBtn.isHidden = false
                ActivityIndicator.isHidden = true
                ActivityIndicator.stopAnimating()
                if countTries < maxRetries { RetryBtn.isEnabled = true }
            }
        }
    }
    
    private func fetchImageAsync() {
        RetryBtn.isHidden = true
        RetryBtn.isEnabled = false
        ActivityIndicator.startAnimating()
     
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
                self.fetchImage()
            }
    }
    
    private var imageView = UIImageView()
    
    //computed variable.
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = NSURL(string: sampleUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
/*
//
//  ViewController.swift
//  SlowWorker
//
//  Created by Monika on 2017-08-14.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var resultsTextView: UITextView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi there"
    }
    
    func processData(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        return "Number of chars: \(data.characters.count)"
    }
    
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
    
    @IBAction func doWord(_ sender: AnyObject) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        startButton.isEnabled = false
        self.spinner.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(fetchedData)
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            queue.async(group: group){
                firstResult = self.calculateFirstResult(processedData)
            }
            queue.async(group: group){
                secondResult = self.calculateSecondResult(processedData)
            }
            group.notify(queue: queue) {
                
            }
            group.notify(queue: queue) {
                let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.startButton.isEnabled = true
                    self.spinner.stopAnimating()
                }
                let endTime = NSDate()
                print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
            }}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
*/
