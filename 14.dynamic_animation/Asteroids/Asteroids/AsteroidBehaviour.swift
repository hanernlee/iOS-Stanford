//
//  AsteroidBehaviour.swift
//  Asteroids
//
//  Created by Christopher Lee on 30/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class AsteroidBehaviour: UIDynamicBehavior, UICollisionBehaviorDelegate {
    private lazy var collider: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        
        behavior.collisionMode = .everything
        behavior.translatesReferenceBoundsIntoBoundary = true
        behavior.collisionDelegate = self
        
        return behavior
    }()
    
    private lazy var physics: UIDynamicItemBehavior = {
       let behavior = UIDynamicItemBehavior()
        
        behavior.elasticity = 1
        behavior.allowsRotation = true
        behavior.friction = 0
        behavior.resistance = 0
        
        return behavior
    }()
    
    private var collisionHandlers = [String:()->Void]()
    func setBoundary(_ path: UIBezierPath?, named name: String, handler: (()->Void)?) {
        collider.removeBoundary(withIdentifier: name as NSString)
        collisionHandlers[name] = nil
        
        
        if path != nil {
            collider.addBoundary(withIdentifier: name as NSString, for: path!)
            collisionHandlers[name] = handler
        }
        
    }
    
    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying?,
        at p: CGPoint) {
        if let name = identifier as? String, let handler = collisionHandlers[name] {
            handler()
        }
    }
    
    override init() {
        super.init()
        addChildBehavior(collider)
        addChildBehavior(physics)
    }
    
    func addAsteroid(_ asteroid: AsteroidView) {
        asteroids.append(asteroid)
        collider.addItem(asteroid)
        physics.addItem(asteroid)
    }
    
    func removeAsteroid(_ asteroid: AsteroidView) {
        if let index = asteroids.index(of: asteroid) {
            asteroids.remove(at: index)
        }
        collider.removeItem(asteroid)
        physics.removeItem(asteroid)
    }
    
    func pushAllAsteroids(by magnitude: Range<CGFloat> = 0..<0.5) {
        for asteroid in asteroids {
            let pusher = UIPushBehavior(items: [asteroid], mode: .instantaneous)
            pusher.magnitude = CGFloat.random(in: magnitude)
            pusher.angle = CGFloat.random(in: 0..<CGFloat.pi * 2)
            addChildBehavior(pusher)
        }
    }
    
    private var asteroids = [AsteroidView]()
}
