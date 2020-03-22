//
//  VideoBackgroundViewController.swift
//  VideoBackgroundLogIn
//
//  Created by FanYu on 18/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit


class VideoBackgroundViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //playVideo()
        //avPlayerForVideoController()
        avPlayerForBackgroundVideo()
        login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.removeObserver(self, forKeyPath: AVPlayerItemDidPlayToEndTimeNotification)
    }
    
    // MARK: - MPMoviePlayer play in background
    private func playVideo() {
        let path = NSBundle.mainBundle().pathForResource("video", ofType: "mov")
        let url = NSURL.fileURLWithPath(path!)
        
        // player
        let moviePlayer = MPMoviePlayerController(contentURL: url)
        if let player = moviePlayer {
            player.view.frame = self.view.bounds
            player.controlStyle = MPMovieControlStyle.None
            player.prepareToPlay()
            player.repeatMode = .One
            player.scalingMode = .AspectFill

            self.view.addSubview(player.view)
        }
    }
    
    // MARK: - avPlayer play video in background
    var player: AVPlayer?
    private func avPlayerForBackgroundVideo() {
        let path = NSBundle.mainBundle().pathForResource("video", ofType: "mov")
        let url = NSURL.fileURLWithPath(path!)
        
        // player
        player = AVPlayer(URL: url)
    
        // player layer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // sub
        self.view.layer.addSublayer(playerLayer)
        
        // start
        player?.seekToTime(kCMTimeZero) // move cursor
        player!.play()
        
        // observer 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification, object: player!.currentItem)
    }
    func playerItemDidReachEnd() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
    
    // MARK: - play video once by video controller
    private func avPlayerForVideoController() {
        let path = NSBundle.mainBundle().pathForResource("video", ofType: "mov")
        let url = NSURL.fileURLWithPath(path!)

        let player = AVPlayer(URL: url)
        let playerController = AVPlayerViewController()
        
        // self
        playerController.player = player
        playerController.view.frame = self.view.bounds
        
        // sub
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        
        // play
        player.play()
    }
    
    // MARK: - Login
    private func login() {
        let username = UITextField(frame: CGRect(x: 90, y: 100, width: 200, height: 40))
        username.backgroundColor = UIColor.clearColor()
        username.borderStyle = .None
        username.placeholder = "User Name"
        username.textAlignment = .Center
        self.view.addSubview(username)
        
        let signInButton = UIButton(frame: CGRect(x: 150, y: 400, width: 60, height: 44))
        signInButton.backgroundColor = UIColor.clearColor()
        signInButton.setTitle("Sign in", forState: .Normal)
        signInButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: "singInTapped", forControlEvents: .TouchUpInside)
    }
    func singInTapped() {
        print("Sing In Tapped")
        
    }
    
}
