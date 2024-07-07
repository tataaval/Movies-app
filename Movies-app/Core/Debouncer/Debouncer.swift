//
//  Debouncer.swift
//  Movies-app
//
//  Created by Tatarella on 06.07.24.
//

import Foundation


class Debouncer {
    private var timer: Timer?
    private let delay: TimeInterval
    private let work: () -> Void

    init(delay: TimeInterval, work: @escaping () -> Void) {
        self.delay = delay
        self.work = work
    }

    func call() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            self.work()
        }
    }
}
