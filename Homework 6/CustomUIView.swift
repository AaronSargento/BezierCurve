//
//  CustomUIView.swift
//  Homework 6
//
//  Created by Aaron Sargento on 2/23/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

// Input: The user can press buttons to manipulate the view, display stats, and delete stats.
// Output: If user presses "Add View", they will see a new curve and the iteration number. If the user presses "Reset View", they will see no curves and the iteration is at 0. If the user presses "Display Point T stats", the stats of the iteration is shown in the text box. If the user presses "Delete Point T stats", the text box is empty.

import UIKit

class CustomUIView: UIView {

    @IBOutlet weak var StatView: UITextView!
    
    @IBOutlet weak var NotificationLabel: UILabel!
    
    //set the corners of square as constants
    let LeftTopPoint: CGPoint = CGPoint(x: 100, y: 200)
    let RightTopPoint:CGPoint = CGPoint(x: 300, y: 200)
    let LeftBottomPoint: CGPoint = CGPoint(x: 100, y: 400)
    let RightBottomPoint: CGPoint = CGPoint(x: 300, y: 400)
    
    //program expects to produce 21 iterations of the view
    let expectedIterations: Int = 21
    
    //this varible holds the statistics: Iteration Number, Point T coordinates, and Ratio
    var statistics: String = ""
    
    //this keeps track how times the user updates the view
    var buttonClicked: Int = 0
    
    /*
        This function allows the CustomView to be updated when user presses "Add View".
        It will tell the user how iterations they have and when he/she reach the limit.
    */
    @IBAction func changeView(_ sender: UIButton) {
        if buttonClicked >= expectedIterations {
            NotificationLabel.textColor = UIColor.red
            NotificationLabel.text = "Cannot go past 21 iterations"
        } else {
            statistics = ""
            buttonClicked = buttonClicked + 1
            NotificationLabel.text = "You currently have \(buttonClicked) iterations"
            self.setNeedsDisplay()
        }
    }
    
    /*
        This function resets the initial view
    */
    @IBAction func resetView(_ sender: UIButton) {
        buttonClicked = 0
        NotificationLabel.textColor = UIColor.black
        NotificationLabel.text = "You currently have \(buttonClicked) iterations"
        statistics = ""
        self.setNeedsDisplay()
    }
    
    /*
        This function displays the statistics at current iteration
    */
    @IBAction func DisplayStats(_ sender: Any) {
        StatView.text = statistics
    }
    
    /*
        This function emptys the text view
    */
    @IBAction func DeleteStats(_ sender: Any) {
        StatView.text = ""
    }
    
    
    /*
        This function performs custom drawing; it will draw our square and diagonal
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0) //line width is 2 pixels
        let colorSpace = CGColorSpaceCreateDeviceRGB() //create color for our view
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0] //components for our color
        let boundarycolor = CGColor(colorSpace: colorSpace, components: components)
        context?.setStrokeColor(boundarycolor!)
        
        //create our square
        let squareSize = CGSize(width: 200.0, height: 200.0)
        let square = CGRect(origin: LeftTopPoint, size: squareSize)
        context?.addRect(square)
        context?.strokePath()
        
        //create our diagonal
        context?.move(to: RightTopPoint)
        context?.addLine(to: LeftBottomPoint)
        context?.strokePath()

        //create our Bezier curves
        createBezierCurves()
    }
    
    /*
        This function creates the Bezier curves within our square
    */
    func createBezierCurves() {
        let context = UIGraphicsGetCurrentContext()
        
        //set initial coordinates for point (top-right corner)
        var pointT: CGPoint = RightTopPoint
        let originalDistance: CGFloat = DistanceFormula(x1: RightTopPoint.x, y1: RightTopPoint.y, x2: LeftBottomPoint.x, y2: LeftBottomPoint.y)
        var ratio: CGFloat = 1.0
        var counter: Int = buttonClicked
        var iterations: Int = 1
        
        while counter != 0  {
            //create Belzeir curves
            context?.move(to: LeftTopPoint)
            context?.addQuadCurve(to: RightBottomPoint, control: pointT)
            context?.strokePath()
            
            //calculate the ratio
            ratio = DistanceFormula(x1: LeftBottomPoint.x, y1: LeftBottomPoint.y, x2: pointT.x, y2: pointT.y) / originalDistance
            
            //debugging: print in console
            print("Iteration Number: \(iterations); Point T: (\(pointT.x); \(pointT.y)); ratio: \(ratio)")
            
            statistics = statistics +
            "Iteration Number: \(iterations)\n Control Point T coordinates: (\(pointT.x), \(pointT.y))\n Ratio: \(ratio) \n\n"
            
            //update the pointT traveling down the diagonal
            pointT.x = pointT.x - 10
            pointT.y = pointT.y + 10
            pointT = CGPoint(x: pointT.x, y: pointT.y)
            iterations = iterations + 1
            counter = counter - 1
        }
    }
    
    /*
        This function will calculate the distance between two points
    */
    func DistanceFormula(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) -> CGFloat {
        let xdiff: CGFloat = pow((x1-x2), 2.0)
        let ydiff: CGFloat = pow((y1-y2), 2.0)
        let distance: CGFloat = pow((xdiff+ydiff), 0.5)
        return distance
    }

}
