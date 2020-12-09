//
//  RadioCollection.swift
//  
//
//  Created by Ahmed Mokhtar on 10/28/20.
//

import SwiftUI

@available(iOS 13.0, *)
internal struct RadioCollection<Data, Content>: View where Data: RandomAccessCollection, Content: View, Data.Element: Identifiable {
    
    private let content: (Data.Element) -> Content
    private let data: Data
    private let trailingSpace: Bool
    @Environment(\.radioButtonColor) private var radioColor
    
    @Binding var selectedData: Data.Element?
    
    public init(selectedData: Binding<Data.Element?>, data: Data, trailingSpace Bool, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self._selectedData = selectedData
        self.trailingSpace = trailingSpace
        self.content = content
        self.data = data
    }
    
    public var body: some View {
        ForEach(data) { element in
            HStack {
                if let selectedData = selectedData, selectedData.id == element.id {
                    Image(systemName: "largecircle.fill.circle")
                        .renderingMode(.template)
                        .foregroundColor(radioColor)
                } else {
                    Image(systemName: "circle")
                        .renderingMode(.template)
                        .foregroundColor(radioColor)
                }
                content(element)
                if trailingSpace && element.id != data.last?.id {
                    Spacer()
                }
            }
            .onTapGesture {
                selectedData = element
            }
        }
        
    }
}


