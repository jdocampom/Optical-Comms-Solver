//
//  DecimalField.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import SwiftUI

struct DecimalField: View {
    
    var placeholder: String
    @Binding var field: String
    
    var body: some View {
        TextField(placeholder, text: $field)
//        TextField(placeholder, text: $field, onCommit: {self.endEditing()})
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .frame(width: 100, height: 30)
            .textSelection(.disabled)
            .onChange(of: field) { _ in
                let filtered = field.filter {"0123456789.".contains($0)}
                if filtered.contains(".") {
                    let splitted = filtered.split(separator: ".", omittingEmptySubsequences: false)
                    if splitted.count >= 2 {
                        let preDecimal = String(splitted[0])
                        let afterDecimal = String(splitted[1])
                        field = "\(preDecimal).\(afterDecimal)"
                    }
                }
            }
    }
    
}
