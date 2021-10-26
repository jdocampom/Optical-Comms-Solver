//
//  RefractiveIndexFromPhaseVelocity.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct RefractiveIndexFromPhaseVelocity: View {
    
    @State var phaseVelocity: String = ""
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Phase Velocity (km/s)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 200000", field: $phaseVelocity)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Refractive Index").customStyle()
                    Spacer()
                    Text(computeRefractiveIndex(from: phaseVelocity))
                }
            }
            .navigationTitle("Refractive Index")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func computeRefractiveIndex(from phaseVelocity: String?) -> String {
        guard let velocity = phaseVelocity, let unwrappedVelocity = Double(velocity) else{ return "-" }
        let speedOfLight: Double = 299792498
        let refractiveIndex = speedOfLight / unwrappedVelocity
        return formatter.string(from: NSNumber(value: refractiveIndex))!
    }
    
}

struct RefractiveIndexFromPhaseVelocity_Previews: PreviewProvider {
    static var previews: some View {
        RefractiveIndexFromPhaseVelocity()
    }
}
