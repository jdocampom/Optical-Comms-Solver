/*:
##  Normalised Frequency and V Parameter
 
 The V number is a dimensionless parameter which is often used in the context of step-index fibers. The V number can be interpreted as a kind of normalized optical frequency. (It is proportional to the optical frequency, but rescaled depending on waveguide properties).
 
 The V number determines the fraction of the optical power in a certain mode which is confined to the fiber core. For single-mode fibers, that fraction is low for low V values (e.g. below 1), and reaches ≈ 90% near the single-mode cut-off at V ≈ 2.405.
 
 The following `NormalisedFrequencyCalculations` struct creates a custom data type used to initialise a calculation for this V parameter in order to compute the number of modes supported by a step index or graded index fiber as well as computing the parameter itself from the wavelength, numerical aperture and fiber radius.
 
 The fiber type (step graded or index graded here is controlled with the `FiberType` enum, which is required at the moment of calling the `computeNormalisedFrequency` instance method or the `numberOfModes` computed property.
*/
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
//: - Experiment:
//: Modify the `testX` constant declarations to experiment with the `.fiberType` computed property and `computeNormalisedFrequency` instance method from the `NormalisedFrequencyCalculations` structure in order not only to compute the number of modes of a fiber depending on the V parameter as well as the fiber type but also to find this V parameter from physical and operational data from the fiber.
//:
let test1 = NormalisedFrequencyCalculations(vParameter: "25", fiberType: .stepIndex)
let test2 = NormalisedFrequencyCalculations(vParameter: "25", fiberType: .gradedIndex)
let test3 = NormalisedFrequencyCalculations().computeNormalisedFrequency(wavelength: "850", fiberRadius: "9.565", numericalAperture: "0.2", fiberType: .stepIndex)
let test4 = NormalisedFrequencyCalculations().computeNormalisedFrequency(wavelength: "850", fiberRadius: "9.565", numericalAperture: "0.2", fiberType: .gradedIndex)

print(test1.numberOfModes)
print(test2.numberOfModes)
print(test3)
print(test4)
//: [Previous](@previous)  |  Page 6 of X  |  [Next](@next)
