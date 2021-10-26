//
//  SnellLawComputation.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import Foundation

struct SnellLawComputation: Identifiable {
    
    enum CalculationType {
        case refractiveIndex1
        case refractiveIndex2
        case incidentAngle
        case transmittedAngle
    }
    
    var id = UUID()
    var refractiveIndex1: String? = nil
    var refractiveIndex2: String? = nil
    var incidentAngle: String? = nil
    var transmittedAngle: String? = nil
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func computeVariable(target: CalculationType, n1: String? = nil, n2: String? = nil, theta1: String? = nil, theta2: String? = nil) -> String {
        switch target {
        case .refractiveIndex1:
            guard let n2 = n2, let theta1 = theta1, let theta2 = theta2  else { return "-" }
            guard let n2 = Double(n2), let theta1 = Double(theta1), let theta2 = Double(theta2) else { return "-" }
            let anglesInRadians = (incident: (theta1 * Double.pi)/180, transmitted: (theta2 * Double.pi)/180)
            let result = (n2 * sin(anglesInRadians.transmitted)) / sin(anglesInRadians.incident)
            return formatter.string(from: NSNumber(value: result))!
        case .refractiveIndex2:
            guard let n1 = n1, let theta1 = theta1, let theta2 = theta2  else { return "-" }
            guard let n1 = Double(n1), let theta1 = Double(theta1), let theta2 = Double(theta2) else { return "-" }
            let anglesInRadians = (incident: (theta1 * Double.pi)/180, transmitted: (theta2 * Double.pi)/180)
            let result = (n1 * sin(anglesInRadians.incident)) / sin(anglesInRadians.transmitted)
            return formatter.string(from: NSNumber(value: result))!
        case .incidentAngle:
            guard let n1 = n1, let n2 = n2, let theta2 = theta2  else { return "-" }
            guard let n1 = Double(n1), let n2 = Double(n2), let theta2 = Double(theta2) else { return "-" }
            let angleInRadians = (theta2 * Double.pi)/180
            let calculation = asin((n2 * sin(angleInRadians))/n1)
            let result = (calculation * 180) / Double.pi
            return formatter.string(from: NSNumber(value: result))!
        case .transmittedAngle:
            guard let n1 = n1, let n2 = n2, let theta1 = theta1  else { return "-" }
            guard let n1 = Double(n1), let n2 = Double(n2), let theta1 = Double(theta1) else { return "-" }
            let angleInRadians = (theta1 * Double.pi)/180
            let calculation = asin((n1 * sin(angleInRadians))/n2)
            let result = (calculation * 180) / Double.pi
            return formatter.string(from: NSNumber(value: result))!
        }
    }
    
    func computeCriticalAngle(n1: String?, n2: String?) -> String {
        return computeVariable(target: .incidentAngle, n1: n1, n2: n2, theta2: "90")
    }
    
}
