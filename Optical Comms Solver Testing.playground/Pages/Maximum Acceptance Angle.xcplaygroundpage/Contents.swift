/*:
##  Maximum Acceptance Angle
 
 The maximum incidence angle of a light ray which can be used for injecting light into a fiber core or waveguide.

 The following `MaxAcceptanceAngleCalculation` struct creates a custom data type used to initialise a calculation for this maximum incidence angle either from the numerical aperture value or from the critical angle.
 
 The variable used for the calculation is controlled with the `AcceptanceAngleCalculationType` enum, which is required at the moment of calling the `compute` instance method.
 
 It's worth mentioning that angles are also measured in degrees here.
*/
import Foundation

struct MaxAcceptanceAngleCalculation: Identifiable {
    
    enum AcceptanceAngleCalculationType {
        case numericalAperture, criticalAngle
    }
    
    var id = UUID()
    var mediumRefractiveIndex: String? = nil
    var coreRefractiveIndex: String? = nil
    var criticalAngle: String? = nil
    var numericalAperture: String? = nil
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func compute(from: AcceptanceAngleCalculationType, n0: String? = nil, n1: String? = nil, theta: String? = nil, na: String? = nil) -> String {
        switch from {
        case .numericalAperture:
            guard let n0 = n0, let na = na else { return "Error" }
            guard let n0 = Double(n0), let na = Double(na) else { return "Error" }
            let calculation = asin(na/n0)
            let result = (calculation * 180)/Double.pi
            return formatter.string(from: NSNumber(value: result))!
        case .criticalAngle:
            guard let n0 = n0, let n1 = n1, let theta = theta  else { return "Error" }
            guard let n0 = Double(n0), let n1 = Double(n1), let theta = Double(theta) else { return "Error" }
            let angleInRadians = (theta * Double.pi)/180
            let calculation = acos((n1 * sin(angleInRadians))/n0)
            let result = (calculation * 180)/Double.pi
            return formatter.string(from: NSNumber(value: result))!
        }
    }
    
}
//: - Experiment:
//: Modify the `testX` constant declarations to experiment with the `compute` instance methods from the `MaxAcceptanceAngleCalculation` structure in order to compute this parameter using several methods.
//:
let test6 = MaxAcceptanceAngleCalculation().compute(from: .numericalAperture,n0: "1.3", n1: "1.6", na: "0.2")
let test7 = MaxAcceptanceAngleCalculation().compute(from: .criticalAngle, n0: "1.6", n1: "1.4", theta: "80")

print("-\tExperiment Results:")
print("NA (Case 1) = \(test6)")
print("NA (Case 2) = \(test7)")
//: [Previous](@previous)  |  Page 4 of X  |  [Numerical Aperture](@next)
