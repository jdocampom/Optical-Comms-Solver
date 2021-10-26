/*:
## Optical to Electrical

The following `struct` creates a custom data type used to initialise an electrical signal alongside with its parameters: frequency and bandwidth (both measured in Terahertz).

It has an instance method that converts those electrical domain parameters to their optical domain equivalents measured in nanometres (wavelength and spectral width).
*/
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
//: - Experiment:
//: Modify the `electricalSignalTest` declaration to convert parameters from an electrical signal to the optical domain.
//:
let electricalSignalTest = ElectricalSignal(frequency: "350", bandwidth: "2.5")

print("-\tElectrical Domain Data:")
print("Frequency: \(electricalSignalTest.frequency ?? "-") THz")
print("Bandwidth: \(electricalSignalTest.bandwidth ?? "-") THz")
print("Frequency Range: \(electricalSignalTest.lowerLimit) - \(electricalSignalTest.upperLimit) THz")
print("")
print("-\tOptical Domain Data:")
print("Wavelength: \(electricalSignalTest.wavelength) nm")
print("Bandwidth: \(electricalSignalTest.spectralWidth) nm")
//: [Previous](@previous)  |  Page 2 of X  |  [Snell's Law](@next)
