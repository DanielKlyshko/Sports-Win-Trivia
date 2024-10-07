import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    private var backgroundPlayer: AVAudioPlayer?
    private var clickPlayer: AVAudioPlayer?
    var isSoundEnabled: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "isSoundEnabled")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "isSoundEnabled")
            }
        }
    
    private init() {
        setupBackgroundSound()
        setupClickSound()
    }
    
    private func setupBackgroundSound() {
        guard let url = Bundle.main.url(forResource: "backGroundMusic", withExtension: "wav") else { return }
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1 // Бесконечный цикл
        } catch {
            print("Ошибка загрузки фоновой музыки: \(error)")
        }
    }
    
    private func setupClickSound() {
        guard let url = Bundle.main.url(forResource: "clickSound", withExtension: "wav") else { return }
        do {
            clickPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Ошибка загрузки звука клика: \(error)")
        }
    }
    
    func playBackgroundSound() {
        backgroundPlayer?.play()
    }
    
    func stopBackgroundSound() {
        backgroundPlayer?.stop()
    }
    
    func playClickSound() {
        if isSoundEnabled {
            clickPlayer?.play()
        }
    }
}
