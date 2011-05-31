# delete all data
curl -XDELETE localhost:9200/

# index some data
curl -XPUT localhost:9200/test/type1/1 -d '{
	"tags" : ["scala", "functional"],
	"count" : 10,
	"price" : 12.5,
	"date" : "2011-05-25"
}'

curl -XPUT localhost:9200/test/type1/2 -d '{
	"tags" : ["clojure", "lisp", "functional"],
	"count" : 5,
	"price" : 15.7,
	"date" : "2011-05-26"
}'

curl -XPUT localhost:9200/test/type1/3 -d '{
	"tags" : ["java", "scala"],
	"count" : 5,
	"price" : 10.7,
	"date" : "2011-05-27"
}'

# Using Query String
curl 'localhost:9200/test/_search?q=tags:scala&pretty=1'
# Same as:
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "query_string" : {
            "query" : "tags:scala"
        }
    }
}'

# Basic (non analyzed queries)
# -> term (non analyzed single term)
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "term" : {
            "tags" : "scala"
        }
    }
}'
# -> term, this won't match, since its not analyzed
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "term" : {
            "tags" : "Scala"
        }
    }
}'
# -> prefix (non analyzed single term)
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "prefix" : {
            "tags" : "sca"
        }
    }
}'
# -> wildcard (non analyzed single term)
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "wildcard" : {
            "tags" : "sca*a"
        }
    }
}'
# -> fuzzy (non analyzed single term)
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "fuzzy" : {
            "tags" : "scalra"
        }
    }
}'

# Text Queries (Analyzed)
# -> text (analyzed and expanded to bool query)
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "text" : {
            "tags" : "clojure java"
        }
    }
}'
# also includes text_phrase and text_phrase_prefix

# Range
# -> range on numeric values
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "range" : {
            "price" : { "gt" : 15 }
        }
    }
}'
# -> and on dates
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "range" : {
            "date" : { "gte" : "2011-05-26" }
        }
    }
}'

# Bool Query
# -> sample with must, also has must_not and should clauses
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "bool" : {
            "must" : [
                { "text" : {
                        "tags" : "scala"
                    }
                }, {
                    "range" : {
                        "price" : { "gt" : 15 }
                    }
                }
            ]
        }
    }
}'

# Filtered Query
#     Filters are similar to queries, except they do no scoring 
#     and are easily cached. 
#     There are many filter types as well, including range and term
curl 'localhost:9200/test/_search?pretty=1' -d '{
    "query" : {
        "filtered" : {
            "query" : {
                "text" : {
                    "tags" : "scala"
                }
            },
            "filter" : {
                "range" : {
                    "price" : { "gt" : 15 }
                }
            }
        }
    }
}'

