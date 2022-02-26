(ns dev.hgranthorner.notes.core
  (:require [dev.hgranthorner.notes.protocols :as p]
            [dev.hgranthorner.notes.xtdb :refer [db]]
            [dev.hgranthorner.notes.core.Note :as n]
            [clojure.spec.alpha      :as s]
            [clojure.spec.test.alpha :as st]
            [clojure.instant         :as i])
  (:import  [java.util Date]))

(s/fdef current-instant
  :args (s/cat)
  :ret  inst?)
(defn current-instant
  "Returns the current date."
  []
  (Date.))


(s/def :->Note/note     string?)
(s/def :->Note/contents string?)
(s/def :->Note/args     (s/keys* :opt-un [:->Note/note :->Note/contents]))
(s/fdef ->Note
  :args (s/cat :args :->Note/args)
  :ret  ::n/note)
(defn ->Note
  [& {:keys [name contents] :or {name "Note" contents ""}}]
  {::n/type :note
   ::n/id   (random-uuid)
   ::n/name name
   ::n/contents contents
   ::n/date (current-instant)})

(->Note :name "egg")

(comment
  (s/exercise-fn `->Note)
  (st/check `->Note)
  (st/instrument `->Note)
  (->Note )
  )
