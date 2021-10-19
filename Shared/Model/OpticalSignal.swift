//
//  OpticalSignal.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import Foundation

struct OpticalSignal: Identifiable {
    
    let speedOfLight: Double = 3E8
    var id = UUID()
    var title: String = "Wavelength to Frequency"
    var wavelength: String?
    var spectralWidth: String?
    var frequency: String { return toElectricalDomain(lambda: wavelength, spectralWidth: spectralWidth).frequency }
    var lowerLimit: String { return toElectricalDomain(lambda: wavelength, spectralWidth: spectralWidth).lowerLimit }
    var upperLimit: String { return toElectricalDomain(lambda: wavelength, spectralWidth: spectralWidth).upperLimit }
    var bandwidth: String { return toElectricalDomain(lambda: wavelength, spectralWidth: spectralWidth).bandwidth }
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        return formatter
    }
    
    /// Tag: Convert from Optical to Electrical Domain
    func toElectricalDomain(lambda: String?, spectralWidth: String?) -> (frequency: String, upperLimit: String, lowerLimit: String, bandwidth: String) {
        // Optional Unwrapping
        guard let lambda = lambda, let spectralWidth = spectralWidth else {
            let frequency = "-", upperLimit = "-", lowerLimit = "-", bandwidth = "-"
            return (frequency, upperLimit, lowerLimit, bandwidth)
        }
        guard let wavelength = Double(lambda) , let spectralWidth = Double(spectralWidth) else {
            let frequency = "-", upperLimit = "-", lowerLimit = "-", bandwidth = "-"
            return (frequency, upperLimit, lowerLimit, bandwidth)
        }
        // Unit Scaling
        let scaledWavelength = wavelength * 1E-9
        let scaledSpectralWidth = spectralWidth * 1E-9
        // Performing Calculations
        let f: Double = (speedOfLight / scaledWavelength) / 1E12
        let fh: Double = (speedOfLight / (scaledWavelength - (scaledSpectralWidth/2))) / 1E12
        let fl: Double = (speedOfLight / (scaledWavelength + (scaledSpectralWidth/2))) / 1E12
        let bw: Double =  fh - fl
        // String Formatting
        let frequency = formatter.string(from: NSNumber(value: f))!
        let upperLimit = formatter.string(from: NSNumber(value: fh))!
        let lowerLimit =  formatter.string(from: NSNumber(value: fl))!
        let bandwidth = formatter.string(from: NSNumber(value: bw))!
        return (frequency, upperLimit, lowerLimit, bandwidth)
    }
}
