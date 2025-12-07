import Foundation
import Combine

final class StoryTimerManager: ObservableObject {
    // MARK: - Published Properties
    @Published var progress: CGFloat = 0
    
    // MARK: - Private Properties
    private let configuration: Configuration
    private var timer: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    // MARK: - Configuration
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
    
    // MARK: - Initialization
    init(configuration: Configuration) {
        self.configuration = configuration
        self.timer = Self.createTimer(interval: configuration.timerTickInterval)
    }
    
    // MARK: - Timer Control
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
    
    // MARK: - Progress Control
    func setProgress(_ newProgress: CGFloat) {
        progress = newProgress
    }
    
    // MARK: - Private Methods
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
