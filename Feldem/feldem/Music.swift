//
//  Music.swift
//  Feldem
//
//  Created by Gustavo Travassos on 07/08/19.
//  Copyright © 2019 Marcus Vinicius Vieira Badiale. All rights reserved.
//

import AVFoundation

var LightWorldPlayer: AVAudioPlayer?
var DarkWorldPlayer: AVAudioPlayer?

// criar classe
public func playMusic() {
    guard let LightUrl = Bundle.main.url(forResource: "LightWorldSong", withExtension: "m4a") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        LightWorldPlayer = try AVAudioPlayer(contentsOf: LightUrl, fileTypeHint: AVFileType.mp3.rawValue)
        guard let LightWorldPlayer = LightWorldPlayer else { return }
        LightWorldPlayer.numberOfLoops = -1
        LightWorldPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    
    guard let DarkUrl = Bundle.main.url(forResource: "DarkWorldSong", withExtension: "m4a") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        DarkWorldPlayer = try AVAudioPlayer(contentsOf: DarkUrl, fileTypeHint: AVFileType.mp3.rawValue)
        guard let DarkWorldPlayer = DarkWorldPlayer else { return }
        DarkWorldPlayer.numberOfLoops = -1
        DarkWorldPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
}

public func switchSongs(mode: Bool) {
    if mode == true {
        LightWorldPlayer?.volume = 10
        DarkWorldPlayer?.volume = 0
    } else {
        DarkWorldPlayer?.volume = 10
        LightWorldPlayer?.volume = 0
    }
}
