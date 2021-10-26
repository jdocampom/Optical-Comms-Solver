/*:
## Electrical to Optical

The following `struct` creates a custom data type used to initialise an optical signal alongside with its parameters: wavelength and spectral width (both measured in nanometres).

It has an instance method that converts those optical domain parameters to their electrical equivalents measured in THz (frequency, bandwidth and frequency range).
*/
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
    
    func format(number: String?) -> String {
        guard let number = number, let unwrappedNumber = Double(number) else{ return "-" }
        let formattedNumber = formatter.string(from: NSNumber(value: unwrappedNumber))!
        return formattedNumber
    }
    
    /// Tag: Convert from Optical to Electrical Domain
    func toElectricalDomain(lambda: String?, spectralWidth: String?) -> (frequency: String, upperLimit: String, lowerLimit: String, bandwidth: String) {
        // Optional Unwrapping
        guard let lambda = lambda, let spectralWidth = spectralWidth, let unwrappedWavelength = Double(lambda) , let unwrappedSpectralWidth = Double(spectralWidth) else {
            let frequency = "-", upperLimit = "-", lowerLimit = "-", bandwidth = "-"
            return (frequency, upperLimit, lowerLimit, bandwidth)
        }
        // Unit Scaling
        let scaledWavelength = unwrappedWavelength * 1E-9
        let scaledSpectralWidth = unwrappedSpectralWidth * 1E-9
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
//: - Experiment:
//: Modify the `opticalSignalTest` declaration to convert parameters from an optical signal to the electrical domain.
//:
let opticalSignalTest = OpticalSignal(wavelength: "1550", spectralWidth: "10")

print("-\tOptical Domain Data:")
print("Wavelength: \(opticalSignalTest.wavelength ?? "-") nm")
print("Bandwidth: \(opticalSignalTest.spectralWidth ?? "-") nm")
print("")
print("-\tElectrical Domain Data:")
print("Frequency: \(opticalSignalTest.frequency) THz")
print("Bandwidth: \(opticalSignalTest.bandwidth) THz")
print("Frequency Range: \(opticalSignalTest.lowerLimit) - \(opticalSignalTest.upperLimit) THz")
//: Page 1 of X  |  [Domain Conversion (Part 2)](@next)

