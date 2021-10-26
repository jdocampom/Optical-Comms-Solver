//
//  ContentView.swift
//  Shared
//
//  Created by Juan Diego Ocampo on 10/15/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Domain Conversions")) {
                    List {
                        NavigationLink(destination: OpticalToElectrical()) {
                            Text("Optical to Electrical")
                        }
                    }
                    List {
                        NavigationLink(destination: ElectricalToOptical()) {
                            Text("Electrical to Optical")
                        }
                    }
                }
                Section(header: Text("Snell's Law")) {
                    List {
                        NavigationLink(destination: RefractiveIndexFromPhaseVelocity()) {
                            Text("Compute Refractive Index")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeCoreRefractiveIndex_SnellLaw()) {
                            Text("Core Refractive Index")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeCladdingRefractiveIndex_SnellLaw()) {
                            Text("Cladding Refractive Index")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeIncidentAngle_SnellLaw()) {
                            Text("Incident Angle")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeTransmittedAngle_SnellLaw()) {
                            Text("Transmitted Angle")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeCriticalAngle_SnellLaw()) {
                            Text("Critical Angle")
                        }
                    }
                }
                Section(header: Text("Maximum Acceptance Angle")) {
                    List {
                        NavigationLink(destination: ComputeAcceptanceAngleFromNA()) {
                            Text("From Numerical Aperture")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeAcceptanceAngleFromCriticalAngle()) {
                            Text("From Critical Angle")
                        }
                    }
                }
                Section(header: Text("Numerical Aperture")) {
                    List {
                        NavigationLink(destination: ComputeNAFromAcceptanceAngle()) {
                            Text("From Acceptance Angle")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeNAFromCriticalAngle()) {
                            Text("From Critical Angle")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeNAFromRefractiveIndices()) {
                            Text("From Refractive Indices")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeNAFromKnownDeltaN()) {
                            Text("From Known Delta (Graded Index)")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeNAFromUnknownDeltaN()) {
                            Text("From Unknown Delta (Graded Index)")
                        }
                    }
                }
                Section(header: Text("Normalised Frequency")) {
                    List {
                        NavigationLink(destination: ComputeVParameterForStepIndexFiber()) {
                            Text("Step Index Fiber")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeVParameterForGradedIndexFiber()) {
                            Text("Graded Index Fiber")
                        }
                    }
                }
            }
            .navigationTitle("Optical Comms Solver")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
