//
//  NewDefinitionView.swift
//  Defunitionz
//
//  Created by Conqueriings on 22/12/21.
//


import SwiftUI

struct NewDefinitationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var definitions: [Definition]
    
    @State var definition = Definition(name: "",
                                       description: "")
    
    
    
    @State var showSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $definition.name)
                }
                Section(header: Text("Description")) {
                    HStack {
                        TextEditor(text: $definition.description)
                            .frame(width: 300, height: 300)
                            .multilineTextAlignment(.leading)
                    }
                }
                
            }
            
            .navigationTitle("New Definition")
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        //                        showSheet.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red),
                trailing:
                    Button("Save") {
                        definitions.append(definition)
                        //                        showSheet.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
            )
        }
    }
}

struct NewDefinitationView_Previews: PreviewProvider {
    static var previews: some View {
        NewDefinitationView(definitions: .constant([]))
    }
}
