(ns dev.hgranthorner.notes.protocols)

(defprotocol Repository
  (get-notes [_] "Returns a seq of notes."))
