;; Monitoring Coordination Contract
;; Coordinates risk monitoring activities

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_MONITOR_NOT_FOUND (err u401))
(define-constant ERR_INVALID_FREQUENCY (err u402))

;; Monitoring frequencies
(define-constant FREQUENCY_DAILY u1)
(define-constant FREQUENCY_WEEKLY u7)
(define-constant FREQUENCY_MONTHLY u30)

;; Data structures
(define-data-var monitor-counter uint u0)
(define-map monitoring-tasks uint {
    risk-id: uint,
    monitor-type: (string-ascii 50),
    frequency: uint,
    assigned-monitor: principal,
    last-check: uint,
    next-check: uint,
    status: (string-ascii 20),
    created-at: uint
})

(define-map monitoring-reports uint {
    task-id: uint,
    report-date: uint,
    findings: (string-ascii 300),
    risk-level-change: int,
    reporter: principal
})

;; Create monitoring task
(define-public (create-monitoring-task
    (risk-id uint)
    (monitor-type (string-ascii 50))
    (frequency uint)
    (assigned-monitor principal))
    (let ((task-id (+ (var-get monitor-counter) u1)))
        (begin
            (asserts! (or (is-eq frequency FREQUENCY_DAILY)
                         (is-eq frequency FREQUENCY_WEEKLY)
                         (is-eq frequency FREQUENCY_MONTHLY)) ERR_INVALID_FREQUENCY)
            (map-set monitoring-tasks task-id {
                risk-id: risk-id,
                monitor-type: monitor-type,
                frequency: frequency,
                assigned-monitor: assigned-monitor,
                last-check: u0,
                next-check: (+ block-height frequency),
                status: "active",
                created-at: block-height
            })
            (var-set monitor-counter task-id)
            (ok task-id)
        )
    )
)

;; Submit monitoring report
(define-public (submit-monitoring-report
    (task-id uint)
    (findings (string-ascii 300))
    (risk-level-change int))
    (let ((task (unwrap! (map-get? monitoring-tasks task-id) ERR_MONITOR_NOT_FOUND)))
        (begin
            (asserts! (is-eq tx-sender (get assigned-monitor task)) ERR_UNAUTHORIZED)
            (map-set monitoring-reports task-id {
                task-id: task-id,
                report-date: block-height,
                findings: findings,
                risk-level-change: risk-level-change,
                reporter: tx-sender
            })
            (map-set monitoring-tasks task-id (merge task {
                last-check: block-height,
                next-check: (+ block-height (get frequency task))
            }))
            (ok true)
        )
    )
)

;; Get monitoring task
(define-read-only (get-monitoring-task (task-id uint))
    (map-get? monitoring-tasks task-id)
)

;; Get monitoring report
(define-read-only (get-monitoring-report (task-id uint))
    (map-get? monitoring-reports task-id)
)
