//
//  ElectricalSignal.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import Foundation

struct ElectricalSignal: Identifiable {
    
    var id = UUID()
    var frequency: String?
    var bandwidth: String?
    var title: String = "Frequency to Wavelength"

    var lowerLimit: String {
        if let frequency = Double(frequency!), let bandwidth = Double(bandwidth!) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 3
            let result = (frequency - bandwidth/2)
            return formatter.string(from: NSNumber(value: result))!
        } else {
            return "-"
        }
    }
    
    var upperLimit: String {
        if let frequency = Double(frequency!), let bandwidth = Double(bandwidth!) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 3
            let result = (frequency + bandwidth/2)
            return formatter.string(from: NSNumber(value: result))!
        } else {
            return "-"
        }
    }
    
    var wavelength: String {
        return frequencyToWavelength(frequency: frequency, bandwidth: bandwidth).wavelength
    }
    
    var spectralWidth: String {
        return frequencyToWavelength(frequency: frequency, bandwidth: bandwidth).spectralWidth
    }
    
    func frequencyToWavelength(frequency: String?, bandwidth: String?) -> (wavelength: String, spectralWidth: String) {
        if let unrappedFrequency = Double(frequency!), let unrapppedBandwidth = Double(bandwidth!) {
            let frequency = unrappedFrequency * 1E12
            _ = unrapppedBandwidth * 1E12
            let lowerLimit = Double(self.lowerLimit)! * 1E12
            let upperLimit = Double(self.upperLimit)! * 1E12
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 1
            formatter.usesGroupingSeparator = false
            /// Speed of Light Constant
            let speedOfLight: Double = 3E8
            /// Compute Frequency from Wavelength
            let lambda: Double = (speedOfLight / frequency) * 1E9
            let wavelength = formatter.string(from: NSNumber(value: lambda))!
            /// Compute Spectral Width
            let spectralWidthLowerLimit: Double = (speedOfLight / lowerLimit)
            let spectralWidthUpperLimit: Double = (speedOfLight / upperLimit)
            let deltaLambda: Double = (spectralWidthLowerLimit - spectralWidthUpperLimit) * 1E9
            let spectralWidth = formatter.string(from: NSNumber(value: deltaLambda))!
            /// Display Results in THz
            return (wavelength, spectralWidth)
        } else {
            let wavelength = "-"
            let spectralWidth = "-"
            return (wavelength, spectralWidth)
        }
    }
    
}
