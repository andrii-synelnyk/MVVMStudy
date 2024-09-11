//
//  NumberRowView.swift
//  MVVMStudy
//
//  Created by Андрей Синельник on 11.09.2024.
//

import SwiftUI

struct NumberRowView: View {
    let numberStorage: NumberStorage
    @State private var showAlert = false
    var onConfirm: () -> Void
    
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            Text("\(numberStorage.number)")
                .foregroundColor(.primary)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Confirm Change"),
                message: Text("Are you sure you want to restore to saved number?"),
                primaryButton: .destructive(Text("Change")) {
                    onConfirm()
                },
                secondaryButton: .cancel(Text("Cancel")) {
                }
            )
        }
    }
}
