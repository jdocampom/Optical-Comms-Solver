//
//  OpticalSignal.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import Foundation

struct OpticalSignal: Identifiable {
    
    var id = UUID()
    var wavelength: String?
    var spectralWidth: String?
    var title: String = "Wavelength to Frequency"
    var frequency: String { return wavelengthToFrequency(lambda: wavelength, spectralWidth: spectralWidth).frequency }
    var lowerLimit: String { return wavelengthToFrequency(lambda: wavelength, spectralWidth: spectralWidth).lowerLimit }
    var upperLimit: String { return wavelengthToFrequency(lambda: wavelength, spectralWidth: spectralWidth).upperLimit }
    var bandwidth: String { return wavelengthToFrequency(lambda: wavelength, spectralWidth: spectralWidth).bandwidth }
    
    func wavelengthToFrequency(lambda: String?, spectralWidth: String?) -> (frequency: String, upperLimit: String, lowerLimit: String, bandwidth: String) {
        if let unrappedWavelength = Double(lambda!), let unwrappedSpectralWidth = Double(spectralWidth!) {
            let wavelength = unrappedWavelength * 1E-9
            let gap = unwrappedSpectralWidth * 1E-9
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 3
            /// Speed of Light Constant
            let speedOfLight: Double = 3E8
            /// Compute Frequency from Wavelength
            let f: Double = (speedOfLight / wavelength) / 1E12
            let frequency = formatter.string(from: NSNumber(value: f))!
            /// Compute Upper Frequency Limit (ƛ - Δƛ/2)
            let fh: Double = (speedOfLight / (wavelength - (gap/2))) / 1E12
            let upperLimit = formatter.string(from: NSNumber(value: fh))!
            /// Compute Lower Frequency Limit (ƛ + Δƛ/2)
            let fl: Double = (speedOfLight / (wavelength + (gap/2))) / 1E12
            let lowerLimit =  formatter.string(from: NSNumber(value: fl))!
            /// Compute Bandwidth
            let bw: Double =  fh - fl
            let bandwidth = formatter.string(from: NSNumber(value: bw))!
            /// Display Results in THz
            return (frequency, upperLimit, lowerLimit, bandwidth)
        } else {
            let frequency = "-"
            let upperLimit = "-"
            let lowerLimit = "-"
            let bandwidth = "-"
            return (frequency, upperLimit, lowerLimit, bandwidth)
        }
    }
    
}
