//
//  ViewController.swift
//  SpringAnimsAreBroken
//
//  Created by Nick Grabenstein on 6/25/24.
//

import UIKit


class MyViewController: UIViewController {

    @IBOutlet weak var animView: UIView!
    @IBOutlet weak var brokenView: UIView!
    
    var isBig = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        brokenView.border(1, color: .red)
        animView.border(1, color: .blue)
        
        animView.frame = CGRect(x: view.frame.midX - 120, y: view.frame.midY - 180, width: 240, height: 360)
        
        brokenView.translatesAutoresizingMaskIntoConstraints = false
        
        let ac = brokenView.widthAnchor.constraint(equalTo: brokenView.heightAnchor, multiplier: 9/16)
        let xc = brokenView.centerXAnchor.constraint(equalTo: animView.centerXAnchor)
        let yc = brokenView.centerYAnchor.constraint(equalTo: animView.centerYAnchor)
        let widthC = brokenView.widthAnchor.constraint(equalTo: animView.widthAnchor)
        widthC.priority = .defaultLow
        let gewc = brokenView.widthAnchor.constraint(greaterThanOrEqualTo: animView.widthAnchor)
        let geHC = brokenView.heightAnchor.constraint(greaterThanOrEqualTo: animView.heightAnchor)
        geHC.priority = .required
        
        NSLayoutConstraint.activate([
            ac,
            xc,
            yc,
            widthC,
            gewc,
            geHC
        ])
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(MyViewController.handleTap(_:)))
        view.addGestureRecognizer(gr)
    }

    
    @objc func handleTap(_ gr: UITapGestureRecognizer) {
        let newFrame: CGRect
        if isBig {
            newFrame = CGRect(x: view.frame.midX - 120, y: view.frame.midY - 180, width: 240, height: 360)
        } else {
            newFrame = CGRect(x: view.frame.midX - (270/2), y: view.frame.midY - (480/2), width: 270, height: 480)
        }
        let timing = UISpringTimingParameters.init(dampingRatio: 0.01, frequencyResponse: 10)
        let anim = UIViewPropertyAnimator(duration: 10, timingParameters: timing)
        anim.addAnimations {
            self.animView.frame = newFrame
        }
        anim.addCompletion { _ in
            self.isBig = !self.isBig
        }
        anim.startAnimation()
    }

}

extension UIView {
    
    func border(_ width: Float, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = CGFloat(width)
    }
}

extension UISpringTimingParameters {
    public convenience init(dampingRatio: CGFloat, frequencyResponse: CGFloat) {
        
        let mass = 1 as CGFloat
        let stiffness = pow(2 * .pi / frequencyResponse, 2) * mass
        let damping = 4 * .pi * dampingRatio * mass / frequencyResponse
        
        self.init(mass: mass, stiffness: stiffness, damping: damping, initialVelocity: .zero)
    }
}
