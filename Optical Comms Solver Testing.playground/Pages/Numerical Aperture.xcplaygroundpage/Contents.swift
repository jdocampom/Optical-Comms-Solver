//: [Previous](@previous)
import Foundation

func computeMaxAcceptanceAngle(n0: String? = nil, n1: String? = nil, theta: String? = nil, na: String? = nil, from: String) -> String {
    switch from {
    case "numericalAperture":
        guard let n0 = n0, let na = na else { return "Error" }
        guard let n0 = Double(n0), let na = Double(na) else { return "Error" }
        let calculation = asin(na/n0)
        let result = String(format:"%2f", (calculation * 180)/Double.pi)
        return result
    case "criticalAngle":
        guard let n0 = n0, let n1 = n1, let theta = theta  else { return "Error" }
        guard let n0 = Double(n0), let n1 = Double(n1), let theta = Double(theta) else { return "Error" }
        let angleInRadians = (theta * Double.pi)/180
        let calculation = acos((n1 * sin(angleInRadians))/n0)
        let result = String(format:"%2f", (calculation * 180)/Double.pi)
        return result
    default:
        return "Error"
    }
}

print(computeMaxAcceptanceAngle(n0: "1.3", n1: "1.6", na: "0.2", from: "numericalAperture"))
print(computeMaxAcceptanceAngle(n0: "1.6", n1: "1.4", theta: "80", from: "criticalAngle"))



func computeNumericalAperture(n0: String? = nil, n1: String? = nil, n2: String? = nil, delta: String? = nil, thetaA: String? = nil, thetaC: String? = nil, from: String) -> String {
    switch from {
    case "acceptanceAngle":
        guard let n0 = n0, let thetaA = thetaA else { return "Error" }
        guard let n0 = Double(n0), let thetaA = Double(thetaA) else { return "Error" }
        let angleInRadians = (thetaA * Double.pi)/180
        let calculation = n0 * sin(angleInRadians)
        let result = String(format:"%2f", (calculation * 180)/Double.pi)
        return result
    case "criticalAngle":
        guard let n1 = n1, let thetaC = thetaC else { return "Error" }
        guard let n1 = Double(n1), let thetaC = Double(thetaC) else { return "Error" }
        let angleInRadians = (thetaC * Double.pi)/180
        let calculation = n1 * cos(angleInRadians)
        let result = String(format:"%2f", (calculation * 180)/Double.pi)
        return result
    case "refractionIndices":
        guard let n1 = n1, let n2 = n2 else { return "Error" }
        guard let n1 = Double(n1), let n2 = Double(n2) else { return "Error" }
        let calculation = sqrt(pow(n1, 2) - pow(n2, 2))
        let result = String(format:"%2f", (calculation * 180)/Double.pi)
        return result
    case "knownDeltaN":
        guard let n1 = n1, let delta = delta else { return "Error" }
        guard let n1 = Double(n1), let delta = Double(delta) else { return "Error" }
        let calculation = n1 * sqrt(2 * delta)
        let result = String(format:"%2f", calculation)
        return result
    case "unknownDeltaN":
        guard let n1 = n1, let n2 = n2 else { return "Error" }
        guard let n1 = Double(n1), let n2 = Double(n2) else { return "Error" }
        let deltaN = ((pow(n1, 2) - pow(n2, 2)))/(2 * pow(n1, 2))
        let calculation = n1 * sqrt(2 * deltaN)
        let result = String(format:"%2f", calculation)
        return result
    default:
        return "Error"
    }
}

print(computeNumericalAperture(n0: "1.3", thetaA: "20", from: "acceptanceAngle"))
print(computeNumericalAperture(n1: "1.6", thetaC: "80", from: "criticalAngle"))
print(computeNumericalAperture(n1: "1.6", n2: "1.3", from: "refractionIndices"))
print(computeNumericalAperture(n1: "1.3", delta: "0.03", from: "knownDeltaN"))
print(computeNumericalAperture(n1: "1.6", n2: "1.3", from: "unknownDeltaN"))

//: [Next](@next)
