//
//  ComputeVParameterForStepIndexFiber.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/26/21.
//

import SwiftUI

struct ComputeVParameterForStepIndexFiber: View {
    
    @State var vParameter: String = ""
    @State var wavelength: String = ""
    @State var fiberRadius: String = ""
    @State var numericalAperture: String = ""
    
    var body: some View {
        let numberOfModes = NormalisedFrequencyCalculations(vParameter: vParameter, fiberType: .stepIndex)
        let data = NormalisedFrequencyCalculations()
        return Form {
            Section(header: Text("Compute Number of Supported Modes")) {
                HStack{
                    Text("V Parameter").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 15", field: $vParameter)
                }
                HStack {
                    Text("Number of Supported Modes ").customStyle()
                    Spacer()
                    Text(numberOfModes.numberOfModes)
                }
            }
            Section(header: Text("Compute V Parameter")) {
                HStack{
                    Text("Wavelength (nm)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 850", field: $wavelength)
                }
                HStack{
                    Text("Fiber Radius (um)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 17", field: $fiberRadius)
                }
                HStack{
                    Text("Numerical Aperture").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 0.2", field: $numericalAperture)
                }
                HStack {
                    Text("V Parameter").customStyle()
                    Spacer()
                    Text(data.computeNormalisedFrequency(wavelength: wavelength, fiberRadius: fiberRadius, numericalAperture: numericalAperture, fiberType: .stepIndex))
                }
            }
            .navigationTitle("Step Index Fiber")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeVParameterForStepIndexFiber_Previews: PreviewProvider {
    static var previews: some View {
        ComputeVParameterForStepIndexFiber()
    }
}
