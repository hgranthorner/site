(ns dev.hgranthorner.notes.xtdb
  (:require [dev.hgranthorner.notes.protocols :as p]
            [clojure.java.io :as io]
            [xtdb.api :as xt]))

(defn start-xtdb! []
  (letfn [(kv-store [dir]
            {:kv-store {:xtdb/module 'xtdb.rocksdb/->kv-store
                        :db-dir (io/file dir)
                        :sync? true}})]
    (xt/start-node
     {:xtdb/tx-log (kv-store "data/dev/tx-log")
      :xtdb/document-store (kv-store "data/dev/doc-store")
      :xtdb/index-store (kv-store "data/dev/index-store")})))

(defonce xtdb-node (start-xtdb!))

(defn stop-xtdb! []
  (.close xtdb-node))

(defn- query [q]
  (xt/q (xt/db xtdb-node)
        q))
(defn- put [x]
  (if (sequential? x)
    (let [ids (map #(or (:xt/id %) (random-uuid)))]
      (xt/submit-tx
       xtdb-node
       [(mapv (fn [x id] [::xt/put (assoc x :xt/id id)]) x ids)]))
    (let [id (or (:xt/id x) (random-uuid))]
      (xt/submit-tx
       xtdb-node
       [[::xt/put (assoc x :xt/id id)]]))))

(def db
  (reify p/Repository
    (get-notes [_]
      (query '{:find  [(pull ?e [*])]
               :where [[?e :dev.hgranthorner.notes.core/name _]]}))))

(comment

  (xt/submit-tx xtdb-node [[::xt/put
                            {:xt/id "hi2u"
                             :user/name "zig"}]])
  (xt/q (xt/db xtdb-node)
        '{:find  [e]
          :where [[e :user/name "zig"]]} )

  (let [xs [{:name "thing" :xt/id "id"}
            {:name "thing2"}]
        ids (map #(or (:xt/id %) (random-uuid)) xs)]
    [(mapv (fn [x id] [::xt/put (assoc x :xt/id id)]) xs ids)])
  )
