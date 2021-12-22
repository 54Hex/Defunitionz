//
//  DefinitionDetailView.swift
//  Defunitionz
//
//  Created by Conqueriings on 22/12/21.
//

import SwiftUI

struct DefinitationDetailView: View {
    
    
    @State var isSheetPresented = false
    
    @Binding var definition: Definition
    
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            Text(definition.description)
                .font(.system(size: 15, design: .monospaced))
                .frame(width: 300)
                
        }
        
        .navigationTitle(definition.name)
        
    }
}

struct DefinitationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DefinitationDetailView(definition: .constant(Definition(name: "", description: "")))
    }
}

