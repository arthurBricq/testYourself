//
//  GraphView.swift
//  myGraph
//
//  Created by Arthur BRICQ on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView
{
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    @IBInspectable var barColor: UIColor = .black
    @IBInspectable var lineColor: UIColor = .gray
    @IBInspectable var bottomMargin: CGFloat = 50
    
    @IBInspectable var radius: CGFloat = 8
    @IBInspectable var lineWidth: CGFloat = 10
    
    public struct Const {
        static let topMargin: CGFloat = 20
        static let delta: CGFloat = 30
    }
    
    override func draw(_ rect: CGRect)
    {
        // Some variables
        let width = rect.width
        let height = rect.height
        let graphWidth = width - 2*Const.delta
        let graphHeight = height - bottomMargin - Const.topMargin
        let dx = Const.delta
        let dy = Const.topMargin
        let origin = CGPoint(x: dx, y: dy)
        
        // 1 : Création du gradient de couleur sur toute la vue du réctangle
        let context = UIGraphicsGetCurrentContext()!
        let colors  = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations : [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: height)
        
        // 2 : mise en place du gradient sur une vue avec des arrondies
        var cornerRadiusSize = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: cornerRadiusSize)
        path.addClip() // Creating a new area to constraints the new context.
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])
        
        // 3 : Tracer les trois lignes blanches qui délimitent l'espace du graphique.
        let pathLine = UIBezierPath()
        lineColor.setStroke()
        let decalage = graphHeight/2
        
        pathLine.move(to: origin)
        let finalPoint1 = CGPoint(x: dx + graphWidth, y: dy )
        pathLine.addLine(to: finalPoint1)
        
        let initialPoint2 = CGPoint(x: dx, y: dy + decalage)
        pathLine.move(to: initialPoint2)
        let finalPoint2 = CGPoint(x: dx + graphWidth, y: dy + decalage)
        pathLine.addLine(to: finalPoint2)
        
        let initialPoint3 = CGPoint(x: dx, y: dy + 2*decalage)
        pathLine.move(to: initialPoint3)
        let finalPoint3 = CGPoint(x: dx + graphWidth, y: dy + 2*decalage)
        pathLine.addLine(to: finalPoint3)
        
        pathLine.lineWidth = 0.8
        pathLine.stroke()
        
        // 4 : trouver les origines des points x à afficher (en sachant qu'il y a 6 point à créer) et y dessiner des points
        
        let dec = graphWidth/5
        let diameter: CGFloat = lineWidth
        barColor.setFill()
        barColor.setStroke()
        
        for i in 0..<6 {
            let x: CGFloat = dx + CGFloat(i)*dec - diameter/4
            let origin: CGPoint = CGPoint(x: x, y: graphHeight + dy - diameter/2)
            let circle = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: diameter, height: diameter)))
            circle.fill()
            
        }
        
        // 5 : tracer les barres de progression pour chaque qualité
        
        let graphLines = UIBezierPath()
        
        for i in 0..<6
        {
            let x: CGFloat = dx + CGFloat(i)*dec + lineWidth/4
            let y = graphHeight + dy
            let origin: CGPoint = CGPoint(x: x, y: y)
            graphLines.move(to: origin)
            let t = graphHeight*score[i]
            let yFinal: CGFloat = y - t
            let finalPoint = CGPoint(x: x, y: yFinal)
            graphLines.lineWidth = lineWidth
            graphLines.addLine(to: finalPoint)
            graphLines.stroke()
        }
        
    }
    
}

