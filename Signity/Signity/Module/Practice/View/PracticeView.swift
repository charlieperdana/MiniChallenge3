//
//  PracticeView.swift
//  Signity
//
//  Created by Andrean Lay on 03/08/21.
//

import SwiftUI

struct PracticeView: View {
    @StateObject var viewModel = PracticeViewModel()
    @State var value: Double = 0.5
    
    @State var navBarHidden = false
    
    var body: some View {
        ZStack {
            CameraRepresentable() { hands in
                viewModel.detectedHands = hands
            }
            .overlay(
                ZStack {
                    HandLines(for: viewModel.detectedHands)
                        .stroke(Color.green, lineWidth: 2)
                    HandLandmarks(for: viewModel.detectedHands)
                        .fill(Color.green)
                }
            )
            .onTapGesture {
                withAnimation {
                    self.navBarHidden.toggle()
                }
            }
            
            if !self.navBarHidden {
                CameraNavigationBar(title: "Latihan Tiru")
            }
            
            VStack {
                HStack(alignment: .top) {
                    ChatBubble() {
                        Text("Selamat pagi")
                            .padding(.all, 15)
                            .padding(.trailing, 10)
                            .background(Color.white)
                            .opacity(0.85)
                            .modifier(PhraseStyle())
                            .multilineTextAlignment(.leading)
                    }
                    
                    VideoView(videoName: $viewModel.currentVideo, playbackSpeed: $viewModel.playbackSpeed, playbackState: $viewModel.playbackState)
                }
                .padding()
                Spacer()
                HorizontalModules(viewModel: viewModel)
            }
            .padding(.top, self.navBarHidden ? 35 : 75)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
