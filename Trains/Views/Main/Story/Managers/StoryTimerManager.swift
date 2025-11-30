import Foundation
import Combine

final class StoryTimerManager: ObservableObject {
    @Published var progress: CGFloat = 0
    
    private let configuration: Configuration
    private var timer: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    struct Configuration {
        let timerTickInterval: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInterval: TimeInterval = 0.05
        ) {
            self.timerTickInterval = timerTickInterval
            self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInterval
        }
    }
    
    init(configuration: Configuration) {
        self.configuration = configuration
        self.timer = Self.createTimer(interval: configuration.timerTickInterval)
    }
    
    func start() {
        timer = Self.createTimer(interval: configuration.timerTickInterval)
        cancellable = timer
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func pause() {
        cancellable?.cancel()
    }
    
    func reset() {
        pause()
        start()
    }
    
    func setProgress(_ newProgress: CGFloat) {
        progress = newProgress
    }
    
    private func tick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        progress = nextProgress
    }
    
    private static func createTimer(interval: TimeInterval) -> Timer.TimerPublisher {
        Timer.publish(every: interval, on: .main, in: .common)
    }
}
