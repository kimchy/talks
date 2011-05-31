# delete all the data
curl -XDELETE localhost:9200/

# create an index to start to work against
curl -XPUT localhost:9200/test

# register a percolator query against the `test` index, and named "elasticsearch"
curl -XPUT localhost:9200/_percolator/test/elasticsearch?pretty=1 -d '{
    "query" : {
        "text" : {
            "message" : "elasticsearch"
        }
    }
}'

# now, percolate a document and find out which queries match it (note, doc not indexed)
curl -XGET localhost:9200/test/type1/_percolate?pretty=1 -d '{
    "doc" : {
        "message" : "this new elasticsearch percolator feature is nice, borat style"
    }
}'

# percolator queries can be filtered, lets tag them with colors
curl -XPUT localhost:9200/_percolator/test/elasticsearch?pretty=1 -d '{
    "color" : "green",
    "query" : {
        "text" : {
            "message" : "elasticsearch"
        }
    }
}'

curl -XPUT localhost:9200/_percolator/test/kimchy?pretty=1 -d '{
    "color" : "blue",
    "query" : {
        "text" : {
            "message" : "kimchy"
        }
    }
}'

# and now, percolate a doc that matches both
curl -XGET localhost:9200/test/type1/_percolate?pretty=1 -d '{
    "doc" : {
        "message" : "this new elasticsearch percolator feature is nice, kimchy style"
    }
}'

# percolate the same doc, just add filtering on color to it
curl -XGET localhost:9200/test/type1/_percolate?pretty=1 -d '{
    "doc" : {
        "message" : "this new elasticsearch percolator feature is nice, kimchy style"
    },
    "query" : {
        "term" : {
            "color" : "green"
        }
    }
}'

# percolation can also happen whe we index a doc
curl -XPUT 'localhost:9200/test/type1/1?percolate=*&pretty=1' -d '{
    "message" : "this new elasticsearch percolator feature is nice, kimchy style"
}'

# and, it can also be filtered
curl -XPUT 'localhost:9200/test/type1/1?percolate=color:green&pretty=1' -d '{
    "message" : "this new elasticsearch percolator feature is nice, borat style"
}'

