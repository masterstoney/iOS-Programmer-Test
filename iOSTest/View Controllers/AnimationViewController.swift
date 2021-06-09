//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    
    
    
    // MARK: - Properties
    private var panGestureRecognizer = UIPanGestureRecognizer()
    
    private var shakeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "phoneIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 22
        button.backgroundColor = UIColor(red: 0.655, green: 0.925, blue: 0.949, alpha: 1.000)
        button.transform = CGAffineTransform(rotationAngle: -.pi / 5)
        return button
    }()
    
    private var instructionBanner: UIView = {
        let banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4318011558)
        banner.layer.shadowOpacity = 0.8
        banner.layer.shadowRadius = 10
        banner.isHidden = true
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        banner.addSubview(label)
        label.constrainToSuper()
        label.text = "Shake Device"
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(14)
        label.layer.cornerRadius = 15.0
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return banner
    }()
    
    private var logoView: RLLogoView = {
        let view = RLLogoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private var emitterView: RLParticleEmitterView = {
        let view = RLParticleEmitterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var fadeButton: UIButton!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        setupView()
        panGestureRecognizer.addTarget(self, action: #selector(handlePanning(gestureRecog:)))
        logoImageView.addGestureRecognizer(panGestureRecognizer)
        shakeButton.addTarget(self, action: #selector(revealInstructionBanner), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressFade(_ sender: Any) {
        
        let isImageFaded = logoImageView.alpha == 0
        let title = isImageFaded ? "FADE OUT" : "FADE IN"
        self.fadeButton.setTitle(title, for: .normal)
        UIView.animate(withDuration: 0.6) {
            self.logoImageView.alpha = isImageFaded ? 1.0 : 0.0
        }
    }
    
    @objc func handlePanning(gestureRecog: UIPanGestureRecognizer) {
        
        let translation = gestureRecog.translation(in: view)
        guard let gestureView = gestureRecog.view else {return}
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gestureRecog.setTranslation(.zero, in: view)
        
        guard gestureRecog.state == .ended else {return}
        let velocity = gestureRecog.velocity(in: view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        let slideMultiplier = magnitude / 200
        let slideFactor = 0.1 * slideMultiplier
        var finalPoint = CGPoint(
            x: gestureView.center.x + (velocity.x * slideFactor),
            y: gestureView.center.y + (velocity.y * slideFactor)
        )
        finalPoint.x = min(max(finalPoint.x,0), view.bounds.width)
        finalPoint.y = min(max(finalPoint.y,0), view.bounds.height)
        
        UIView.animate(withDuration: Double(slideFactor * 2),
                       delay: 0,
                       options: .curveEaseOut) {
            gestureView.center = finalPoint
        }
    }
    
    @objc func revealInstructionBanner() {
        
        instructionBanner.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.instructionBanner.transform = CGAffineTransform(translationX: 0, y: 50)
        } completion: { _ in
            if #available(iOS 10.0, *) {
                let impactFeedbackGenerator = UIImpactFeedbackGenerator()
                impactFeedbackGenerator.prepare()
                impactFeedbackGenerator.impactOccurred()
            }
            self.shakeButton.isHidden = true
            UIView.animate(withDuration: 0.4,
                           delay: 3.0,
                           options: .curveEaseOut) {
                self.instructionBanner.transform = CGAffineTransform(translationX: 0, y: 0)
            } completion: { _ in
                self.instructionBanner.isHidden = true
            }
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        fadeButton.isHidden = true
        logoImageView.isHidden = true
        shakeButton.isHidden = true
        logoView.isHidden = false
        emitterView.isHidden = false
        logoView.animate()
    }
    
    // MARK: - Methods
    private func setupView() {
        
        logoView.animationDelegate = self
        emitterView.animationDelegate = self
        
        view.addSubview(emitterView)
        view.addSubview(logoView)
        view.addSubview(shakeButton)
        view.addSubview(instructionBanner)
        
        
        view.sendSubviewToBack(logoView)
        view.sendSubviewToBack(emitterView)
        
        shakeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        shakeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        shakeButton.bottomAnchor.constraint(equalTo: fadeButton.topAnchor, constant: -16).isActive = true
        shakeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        instructionBanner.widthAnchor.constraint(equalToConstant: 120).isActive = true
        instructionBanner.heightAnchor.constraint(equalToConstant: 35).isActive = true
        instructionBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructionBanner.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true

        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        emitterView.constrainToSuper()
        emitterView.backgroundColor = view.backgroundColor
        
    }
    
    private func animateButton() {
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       options: [.curveLinear, .repeat, .autoreverse, .allowUserInteraction],
                       animations: {
                        self.shakeButton.transform = CGAffineTransform(rotationAngle: .pi / 5)
                        self.shakeButton.imageView?.tintColor = UIColor(red: 0.867, green: 0.110, blue: 0.416, alpha: 1.000)
                       },
                       completion: nil)
    }
    
}


    //MARK: - RLAnimationDelegate Methods
extension AnimationViewController: RLAnimationDelegate {
    
    func completed(by caller: RLAnimationCaller) {
        
        switch caller {
        case .logoView:
            self.emitterView.animate()
        case .particleEmitterView:
            UIView.animate(withDuration: 0.6) {
                self.emitterView.backgroundColor = self.view.backgroundColor
                self.fadeButton.isHidden = false
                self.logoImageView.isHidden = false
                self.logoView.isHidden = true
            } completion: { _ in
                self.emitterView.isHidden = true
            }
        }
    }
    
}
