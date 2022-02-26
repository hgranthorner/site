(ns dev.hgranthorner.notes.core.Note
  (:require [clojure.spec.alpha :as s]))


(s/def ::type     #{:note})
(s/def ::name     string?)
(s/def ::date     inst?)
(s/def ::contents string?)
(s/def ::id       uuid?)

(s/def ::note (s/keys :req [::type ::name ::date ::contents ::id]))
