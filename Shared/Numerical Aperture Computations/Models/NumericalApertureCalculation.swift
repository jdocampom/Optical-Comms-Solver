//
//  NumericalApertureCalculation.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import Foundation

struct NumericalApertureCalculation: Identifiable {
    
    enum NACalculationType {
        case acceptanceAngle, criticalAngle, refractionIndices, knownDeltaN, unknownDeltaN
    }
    
    var id = UUID()
    var mediumRefractiveIndex: String? = nil
    var coreRefractiveIndex: String? = nil
    var claddingRefractiveIndex: String? = nil
    var refractiveIndexDelta: String? = nil
    var acceptanceAngle: String? = nil
    var criticalAngle: String? = nil
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        return formatter
    }
    
    func compute(from: NACalculationType, n0: String? = nil, n1: String? = nil, n2: String? = nil, delta: String? = nil, thetaA: String? = nil, thetaC: String? = nil) -> String {
        switch from {
        case .acceptanceAngle:
            guard let n0 = n0, let thetaA = thetaA else { return "-" }
            guard let n0 = Double(n0), let thetaA = Double(thetaA) else { return "-" }
            let angleInRadians = (thetaA * Double.pi)/180
            let result = n0 * sin(angleInRadians)
            return formatter.string(from: NSNumber(value: result))!
        case .criticalAngle:
            guard let n1 = n1, let thetaC = thetaC else { return "-" }
            guard let n1 = Double(n1), let thetaC = Double(thetaC) else { return "-" }
            let angleInRadians = (thetaC * Double.pi)/180
            let result = n1 * cos(angleInRadians)
            return formatter.string(from: NSNumber(value: result))!
        case .refractionIndices:
            guard let n1 = n1, let n2 = n2 else { return "-" }
            guard let n1 = Double(n1), let n2 = Double(n2) else { return "-" }
            let result = sqrt(pow(n1, 2) - pow(n2, 2))
            return formatter.string(from: NSNumber(value: result))!
        case .knownDeltaN:
            guard let n1 = n1, let delta = delta else { return "-" }
            guard let n1 = Double(n1), let delta = Double(delta) else { return "-" }
            let result = n1 * sqrt(2 * delta)
            return formatter.string(from: NSNumber(value: result))!
        case .unknownDeltaN:
            guard let n1 = n1, let n2 = n2 else { return "-" }
            guard let n1 = Double(n1), let n2 = Double(n2) else { return "-" }
            let deltaN = ((pow(n1, 2) - pow(n2, 2)))/(2 * pow(n1, 2))
            let result = n1 * sqrt(2 * deltaN)
            return formatter.string(from: NSNumber(value: result))!
        }
    }
    
}
