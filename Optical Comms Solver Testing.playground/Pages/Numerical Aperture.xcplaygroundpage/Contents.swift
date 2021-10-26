/*:
##  Numerical Aperture
 
 In optics, the numerical aperture (NA) of an optical system is a dimensionless number that characterizes the range of angles over which the system can accept or emit light. By incorporating index of refraction in its definition, NA has the property that it is constant for a beam as it goes from one material to another, provided there is no refractive power at the interface.

 The following `NumericalApertureCalculation` struct creates a custom data type used to initialise a calculation for this maximum incidence angle either from the acceptance angle value, the critical angle value or refractive indices (for step-index fibers). There are also two other methods of calculations designed for graded-index fiber: when the delta of the refractive indices is a known parameter or when it's not.
 
 The calculation method here is controlled with the `NACalculationType` enum, which is required at the moment of calling the `compute` instance method.
*/
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
//: - Experiment:
//: Modify the `testX` constant declarations to experiment with the `compute` instance methods from the `NumericalApertureCalculation` structure in order to compute this parameter using several methods.
//:
let test1 = NumericalApertureCalculation().compute(from: .acceptanceAngle, n0: "1.3", thetaA: "22")
let test2 = NumericalApertureCalculation().compute(from: .criticalAngle,n1: "1.6", thetaC: "80")
let test3 = NumericalApertureCalculation().compute(from: .refractionIndices, n1: "1.6", n2: "1.3")
let test4 = NumericalApertureCalculation().compute(from: .knownDeltaN, n1: "1.3", delta: "0.03")
let test5 = NumericalApertureCalculation().compute(from: .unknownDeltaN, n1: "1.6", n2: "1.3")

print("-\tExperiment Results:")
print("NA (Case 1) = \(test1)")
print("NA (Case 2) = \(test2)")
print("NA (Case 3) = \(test3)")
print("NA (Case 4) = \(test4)")
print("NA (Case 5) = \(test5)")
//: [Previous](@previous)  |  Page 5 of X  |  [Normalised Frequency and V Parameter](@next)
