# delete all the data
curl -XDELETE localhost:9200/

# index some data
curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["scala", "java"],
	"count" : 10,
	"price" : 12.5,
	"date" : "2011-05-25T01:52"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["clojure", "java"],
	"count" : 14,
	"price" : 17.5,
	"date" : "2011-05-25T07:52"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["clojure", "lisp"],
	"count" : 7,
	"price" : 5.5,
	"date" : "2011-05-26T03:23"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["ruby", "java"],
	"count" : 7,
	"price" : 5.5,
	"date" : "2011-05-25T07:43"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["perl", "python"],
	"count" : 23,
	"price" : 53.7,
	"date" : "2011-05-24T03:24"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["perl", "ruby"],
	"count" : 14,
	"price" : 12.3,
	"date" : "2011-05-29T03:24"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["python", "ruby"],
	"count" : 14,
	"price" : 12.3,
	"date" : "2011-05-30T07:24"
}'

curl -XPOST localhost:9200/test/type1 -d '{
	"tags" : ["python", "scala"],
	"count" : 4,
	"price" : 3.3,
	"date" : "2011-05-31T07:24"
}'


# Terms Facet
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "tags_f" : {
            "terms" : {
                "field" : "tags"
            }
        }
    }
}'

# Statistical Facet
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "stats_f" : {
            "statistical" : {
                "field" : "price"
            }
        }
    }
}'

# Terms Stats Facet
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "stats_f" : {
            "terms_stats" : {
                "key_field" : "tags",
                "value_field" : "price"
            }
        }
    }
}'

# Range Facet
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "range_f" : {
            "range" : {
                "field" : "count",
                "ranges" : [
                    {"to" : 10},
                    {"from" : 5, "to" : 25},
                    {"from" : 3, "to" : 15}
                ]
            }
        }
    }
}'

# Range Facet with custom value field
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "range_f" : {
            "range" : {
                "field" : "count",
				"value_field" : "price",
                "ranges" : [
                    {"to" : 10},
                    {"from" : 5, "to" : 25},
                    {"from" : 3, "to" : 15}
                ]
            }
        }
    }
}'

# Histogram Facet
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "histo_f" : {
            "histogram" : {
                "field" : "count",
                "interval" : 5
            }
        }
    }
}'

# Histogram with Stats Facet
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "histo_f" : {
            "histogram" : {
                "field" : "count",
                "value_field" : "price",
                "interval" : 5
            }
        }
    }
}'

# Date Histogram
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "histo_f" : {
            "date_histogram" : {
                "field" : "date",
                "interval" : "day"
            }
        }
    }
}'

# Date Histogram with Time Zone
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "histo_f" : {
            "date_histogram" : {
                "field" : "date",
                "time_zone" : "Europe/Paris",
                "interval" : "day"
            }
        }
    }
}'

# Date Histogram with Stats
curl 'localhost:9200/test/_search?search_type=count&pretty=1' -d '{
    "query" : { "match_all" : {}},
    "facets" : {
        "histo_f" : {
            "date_histogram" : {
                "field" : "date",
                "value_field" : "price",
                "interval" : "day"
            }
        }
    }
}'
