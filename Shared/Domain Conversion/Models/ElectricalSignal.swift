//
//  ElectricalSignal.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import Foundation

struct ElectricalSignal: Identifiable {
    
    let speedOfLight: Double = 3E8
    var id = UUID()
    var frequency: String?
    var bandwidth: String?
    var title: String = "Frequency to Wavelength"
    var wavelength: String { return toOpticalDomain(frequency: frequency, bandwidth: bandwidth).wavelength }
    var spectralWidth: String { return toOpticalDomain(frequency: frequency, bandwidth: bandwidth).spectralWidth }
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
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        return formatter
    }
    
    func format(number: String?) -> String {
        guard let number = number, let unwrappedNumber = Double(number) else{ return "-" }
        let formattedNumber = formatter.string(from: NSNumber(value: unwrappedNumber))!
        return formattedNumber
    }
    
    /// Tag: Convert from Electrical to Optical Domain
    func toOpticalDomain(frequency: String?, bandwidth: String?) -> (wavelength: String, spectralWidth: String) {
        // Optional Unwrapping
        guard let frequency = frequency, let bandwidth = bandwidth, let unwrappedFrequency = Double(frequency) , let unwrappedBandwidth = Double(bandwidth) else {
            let wavelength = "-", spectralWidth = "-"
            return (wavelength, spectralWidth)
        }
        // Unit Scaling
        let scaledFrequency = unwrappedFrequency * 1E12
        _ = unwrappedBandwidth * 1E12
        let lowerLimit = Double(self.lowerLimit)! * 1E12
        let upperLimit = Double(self.upperLimit)! * 1E12
        // Performing Calculations
        let lambda: Double = (speedOfLight / scaledFrequency) * 1E9
        let spectralWidthLowerLimit: Double = (speedOfLight / lowerLimit)
        let spectralWidthUpperLimit: Double = (speedOfLight / upperLimit)
        let deltaLambda: Double = (spectralWidthLowerLimit - spectralWidthUpperLimit) * 1E9
        // String Formatting
        let wavelength = formatter.string(from: NSNumber(value: lambda))!
        let spectralWidth = formatter.string(from: NSNumber(value: deltaLambda))!
        return (wavelength, spectralWidth)
    }
}
