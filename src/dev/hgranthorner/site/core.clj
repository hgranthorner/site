(ns dev.hgranthorner.site.core
  (:require [clojure.spec.alpha :as s]
            [dev.hgranthorner.site.view :as view]
            [dev.hgranthorner.notes.core :as n]
            [dev.hgranthorner.notes.protocols :as p]
            [dev.hgranthorner.notes.xtdb :refer [db]]
            [hiccup2.core :as h]))

(defn html
  [e]
  (-> e h/html str))

(n/get-notes db)
