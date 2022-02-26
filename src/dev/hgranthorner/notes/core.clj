(ns dev.hgranthorner.notes.core
  (:require [dev.hgranthorner.notes.protocols :as p]
            [dev.hgranthorner.notes.xtdb :refer [db]]
            [clojure.spec.alpha      :as s]
            [clojure.spec.test.alpha :as st]
            [clojure.instant         :as i])
  (:import  [java.util Date]))

(s/def ::type     #{:note})
(s/def ::name     string?)
(s/def ::date     inst?)
(s/def ::contents string?)
(s/def ::id       uuid?)

(s/def ::note (s/keys :req [::type ::name ::date ::contents ::id]))

(s/def :->Note/note     string?)
(s/def :->Note/contents string?)
(s/def :->Note/args     (s/keys* :opt-un [:->Note/note :->Note/contents]))

(s/fdef current-instant
  :args (s/cat)
  :ret  inst?)
(defn current-instant
  "Returns the current date."
  []
  (Date.))

(s/fdef ->Note
  :args (s/cat :args :->Note/args)
  :ret  ::note)
(defn ->Note
  [& {:keys [name contents] :or {name "Note" contents ""}}]
  {::type :note
   ::id   (random-uuid)
   ::name name
   ::contents contents
   ::date (current-instant)})

(defn get-notes
  [db]
  (sequence
   (comp
    (mapcat identity)
    (map ->Note))
   (p/get-notes db)))

(comment
  (->> (s/exercise ::note 1)
       first
       first
       (p/put db))
  (s/exercise-fn `->Note)
  (st/check `->Note)
  (st/instrument `->Note)
  )
