//
//  NormalisedFrequencyCalculations.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/26/21.
//

import Foundation

struct NormalisedFrequencyCalculations: Identifiable {
    
    enum FiberType {
        case stepIndex, gradedIndex
    }
    
    var id = UUID()
    var vParameter: String? = nil
    var fiberType: FiberType?
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        return formatter
    }
    
    var numberOfModes: String {
        guard let vParameter = vParameter, let unwrappedV = Double(vParameter) else { return "-" }
        if fiberType == .stepIndex {
            let result = Int(floor(pow(unwrappedV, 2)/2))
            return String(result)
        } else {
            let result = Int(round(pow(unwrappedV, 2)/4))
            return String(result)
        }
    }
    
    func computeNormalisedFrequency(wavelength: String?, fiberRadius: String?, numericalAperture: String?, fiberType: FiberType) -> String {
        guard let wavelength = wavelength, let fiberRadius = fiberRadius, let numericalAperture = numericalAperture else { return "-" }
        guard let wavelength = Double(wavelength), let fiberRadius = Double(fiberRadius), let numericalAperture = Double(numericalAperture) else { return "-" }
        let scaledWavelength = wavelength / 1E9
        let scaledRadius = fiberRadius / 1E6
        let numberOfModes = ((2 * pow(Double.pi, 2) * pow(scaledRadius, 2)) / pow(scaledWavelength, 2)) * pow(numericalAperture, 2)
        if fiberType == .stepIndex {
            let result = sqrt(2 * numberOfModes)
            return formatter.string(from: NSNumber(value: result))!
        } else {
            let result = sqrt(4 * numberOfModes)
            return formatter.string(from: NSNumber(value: result))!
        }
    }
    
}
