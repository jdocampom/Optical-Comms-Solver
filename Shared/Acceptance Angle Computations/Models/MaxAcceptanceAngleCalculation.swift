//
//  MaxAcceptanceAngleCalculation.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import Foundation

struct MaxAcceptanceAngleCalculation: Identifiable {
    
    enum AcceptanceAngleCalculationType {
        case numericalAperture, criticalAngle
    }
    
    var id = UUID()
    var mediumRefractiveIndex: String? = nil
    var coreRefractiveIndex: String? = nil
    var criticalAngle: String? = nil
    var numericalAperture: String? = nil
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func compute(from: AcceptanceAngleCalculationType, n0: String? = nil, n1: String? = nil, theta: String? = nil, na: String? = nil) -> String {
        switch from {
        case .numericalAperture:
            guard let n0 = n0, let na = na else { return "-" }
            guard let n0 = Double(n0), let na = Double(na) else { return "-" }
            let calculation = asin(na/n0)
            let result = (calculation * 180)/Double.pi
            return formatter.string(from: NSNumber(value: result))!
        case .criticalAngle:
            guard let n0 = n0, let n1 = n1, let theta = theta  else { return "-" }
            guard let n0 = Double(n0), let n1 = Double(n1), let theta = Double(theta) else { return "-" }
            let angleInRadians = (theta * Double.pi)/180
            let calculation = acos((n1 * sin(angleInRadians))/n0)
            let result = (calculation * 180)/Double.pi
            return formatter.string(from: NSNumber(value: result))!
        }
    }
    
}
