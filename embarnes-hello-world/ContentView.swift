//
//  ContentView.swift
//  embarnes-hello-world
//
//  Created by Edward Barnes on 30/11/2025.
//

import SwiftUI
import PencilKit

struct DrawingCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput // Allows both finger and pencil
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

struct ContentView: View {
    @State private var canvasView = PKCanvasView()
    let toolPicker = PKToolPicker()

    var body: some View {
        DrawingCanvas(canvasView: $canvasView)
            .onAppear {
                toolPicker.setVisible(true, forFirstResponder: canvasView)
                toolPicker.addObserver(canvasView)
                canvasView.becomeFirstResponder()
            }
    }
}


#Preview {
    ContentView()
}
