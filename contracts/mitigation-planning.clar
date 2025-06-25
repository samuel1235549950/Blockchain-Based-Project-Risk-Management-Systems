;; Mitigation Planning Contract
;; Plans and manages risk mitigation strategies

(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_PLAN_NOT_FOUND (err u301))
(define-constant ERR_INVALID_STATUS (err u302))

;; Data structures
(define-data-var plan-counter uint u0)
(define-map mitigation-plans uint {
    risk-id: uint,
    strategy: (string-ascii 200),
    action-items: (string-ascii 500),
    assigned-to: principal,
    target-date: uint,
    budget-required: uint,
    status: (string-ascii 20),
    created-by: principal,
    created-at: uint
})

;; Create mitigation plan
(define-public (create-mitigation-plan
    (risk-id uint)
    (strategy (string-ascii 200))
    (action-items (string-ascii 500))
    (assigned-to principal)
    (target-date uint)
    (budget-required uint))
    (let ((plan-id (+ (var-get plan-counter) u1)))
        (begin
            (map-set mitigation-plans plan-id {
                risk-id: risk-id,
                strategy: strategy,
                action-items: action-items,
                assigned-to: assigned-to,
                target-date: target-date,
                budget-required: budget-required,
                status: "planned",
                created-by: tx-sender,
                created-at: block-height
            })
            (var-set plan-counter plan-id)
            (ok plan-id)
        )
    )
)

;; Get mitigation plan
(define-read-only (get-mitigation-plan (plan-id uint))
    (map-get? mitigation-plans plan-id)
)

;; Update plan status
(define-public (update-plan-status (plan-id uint) (new-status (string-ascii 20)))
    (let ((plan (unwrap! (map-get? mitigation-plans plan-id) ERR_PLAN_NOT_FOUND)))
        (begin
            (asserts! (or (is-eq tx-sender (get assigned-to plan)) (is-eq tx-sender (get created-by plan))) ERR_UNAUTHORIZED)
            (map-set mitigation-plans plan-id (merge plan { status: new-status }))
            (ok true)
        )
    )
)

;; Update action items
(define-public (update-action-items (plan-id uint) (new-action-items (string-ascii 500)))
    (let ((plan (unwrap! (map-get? mitigation-plans plan-id) ERR_PLAN_NOT_FOUND)))
        (begin
            (asserts! (or (is-eq tx-sender (get assigned-to plan)) (is-eq tx-sender (get created-by plan))) ERR_UNAUTHORIZED)
            (map-set mitigation-plans plan-id (merge plan { action-items: new-action-items }))
            (ok true)
        )
    )
)
