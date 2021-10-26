/*:
##  Snell's Law

 The following `struct` creates a custom data type used to initialise a calculation using the Snell Law equation. All variables are initialised as nil since the user will provide not only the target variable but also the values for known parameters.
 
 The target variable is controlled with the `SnellLawComputation` enum, which is required at the moment of calling the `computeVariable` instance method.
 
 It's worth mentioning that angles are measured in degrees.
 */
import Foundation

struct SnellLawComputation: Identifiable {
    
    enum CalculationType {
        case refractiveIndex1
        case refractiveIndex2
        case incidentAngle
        case transmittedAngle
    }
    
    var id = UUID()
    var refractiveIndex1: String? = nil
    var refractiveIndex2: String? = nil
    var incidentAngle: String? = nil
    var transmittedAngle: String? = nil
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        return formatter
    }
    
    func computeVariable(target: CalculationType, n1: String? = nil, n2: String? = nil, theta1: String? = nil, theta2: String? = nil) -> String {
        switch target {
        case .refractiveIndex1:
            guard let n2 = n2, let theta1 = theta1, let theta2 = theta2  else { return "-" }
            guard let n2 = Double(n2), let theta1 = Double(theta1), let theta2 = Double(theta2) else { return "-" }
            let anglesInRadians = (incident: (theta1 * Double.pi)/180, transmitted: (theta2 * Double.pi)/180)
            let result = (n2 * sin(anglesInRadians.transmitted)) / sin(anglesInRadians.incident)
            return formatter.string(from: NSNumber(value: result))!
        case .refractiveIndex2:
            guard let n1 = n1, let theta1 = theta1, let theta2 = theta2  else { return "-" }
            guard let n1 = Double(n1), let theta1 = Double(theta1), let theta2 = Double(theta2) else { return "-" }
            let anglesInRadians = (incident: (theta1 * Double.pi)/180, transmitted: (theta2 * Double.pi)/180)
            let result = (n1 * sin(anglesInRadians.incident)) / sin(anglesInRadians.transmitted)
            return formatter.string(from: NSNumber(value: result))!
        case .incidentAngle:
            guard let n1 = n1, let n2 = n2, let theta2 = theta2  else { return "-" }
            guard let n1 = Double(n1), let n2 = Double(n2), let theta2 = Double(theta2) else { return "-" }
            let angleInRadians = (theta2 * Double.pi)/180
            let calculation = asin((n2 * sin(angleInRadians))/n1)
            let result = (calculation * 180) / Double.pi
            return formatter.string(from: NSNumber(value: result))! + "º"
        case .transmittedAngle:
            guard let n1 = n1, let n2 = n2, let theta1 = theta1  else { return "-" }
            guard let n1 = Double(n1), let n2 = Double(n2), let theta1 = Double(theta1) else { return "-" }
            let angleInRadians = (theta1 * Double.pi)/180
            let calculation = asin((n1 * sin(angleInRadians))/n2)
            let result = (calculation * 180) / Double.pi
            return formatter.string(from: NSNumber(value: result))! + "º"
        }
    }
    
    func computeCriticalAngle(n1: String?, n2: String?) -> String {
        return computeVariable(target: .incidentAngle, n1: n1, n2: n2, theta2: "90")
    }
    
}
//: - Experiment:
//: Modify the `testX` constant declarations to experiment with the `computeVariable` and `computeCriticalAngle` instance methods from the `SnellLawComputation` structure in order to compute several variables using Snell's Law equation from different user provided data. 
//:
let test1 = SnellLawComputation().computeVariable(target: .refractiveIndex1, n2: "1.6", theta1: "57", theta2: "22")
let test2 = SnellLawComputation().computeVariable(target: .refractiveIndex2, n1: "1.4", theta1: "32", theta2: "75")
let test3 = SnellLawComputation().computeVariable(target: .incidentAngle, n1: "1.6", n2: "2.1", theta2: "37")
let test4 = SnellLawComputation().computeVariable(target: .transmittedAngle, n1: "1.3", n2: "1.7", theta1: "80")
let test5 = SnellLawComputation().computeCriticalAngle(n1: "1.6", n2: "1")

print("-\tExperiment Results:")
print("n1 = \(test1)")
print("n2 = \(test2)")
print("theta_i = \(test3)")
print("theta_t = \(test4)")
print("theta_ci = \(test5)")
//: [Previous](@previous)  |  Page 3 of X  |  [Numerical Aperture](@next)
