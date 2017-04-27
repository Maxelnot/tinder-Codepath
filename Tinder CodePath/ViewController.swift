//
//  ViewController.swift
//  Tinder CodePath
//
//  Created by Cong Tam Quang Hoang on 26/04/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    var cardInitialCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragImage(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapImage(_:)))
        
        profileImageView.image = UIImage(named: "ryan")       
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(panGestureRecognizer)
    }
    @IBAction func onTapImage(_ sender: UITapGestureRecognizer) {
        print("tapped")
//        let mainStoryboard = UIStoryboard( name: "Main", bundle: nil)
//        let profileVC = mainStoryboard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        
        self.performSegue(withIdentifier: "toProfileSegue", sender: nil)
    }

    @IBAction func dragImage(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            cardInitialCenter = profileImageView.center
            
        } else if sender.state == .changed {
            
            profileImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            let rotation = CGAffineTransform(rotationAngle: translation.x / 100)
            let CCWrotation = CGAffineTransform(rotationAngle: translation.x / -100)
            
            if (location.y < profileImageView.center.y){
                self.profileImageView.transform = rotation
            }else{
                self.profileImageView.transform = CCWrotation
            }
    
        } else if sender.state == .ended {
            
            if (translation.x > 75){
                UIView.animate(withDuration:0.4, animations: {
                    // This causes first view to fade in and second view to fade out
                    self.profileImageView.alpha = 0
                })
            }else{
                
                UIView.animate(withDuration: 0.4, animations: {
                    self.profileImageView.center = self.cardInitialCenter
                    self.profileImageView.transform = CGAffineTransform.identity
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("preparing")
        if segue.identifier == "toProfileSegue"{
            if let profileController = segue.destination as? ProfileViewController{
                profileController.profileImage = self.profileImageView.image
                print("here")
            }else{
                print("else")
            }
        }else{
            print("wrong")
        }
        
    }

}

