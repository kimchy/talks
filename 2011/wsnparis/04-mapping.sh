# delete all data
curl -XDELETE localhost:9200/

# index a sample doc and see its derived mapping for *type1*
curl -XPUT localhost:9200/test/type1/1?pretty=1 -d '{
	"text" : "some textual content here",
	"count" : 10,
	"price" : 12.45,
	"date" : "2011-05-27T17:10:12"
}'

# see the automatic derived mapping
curl localhost:9200/test/type1/_mapping?pretty=1

# delete test index
curl -XDELETE localhost:9200/test

# force mapping, for example: narrower numeric types, explicit date format, 
# with "_all" disabled
curl -XPUT localhost:9200/test?pretty-1 -d '{
	"mappings" : {
	    "type1" : {
	        "_all" : {"enabled" : false},
	        "properties" : {
	            "count" : {
	                "type" : "integer"
	            },
	            "price" : {
	                "type" : "float"
	            },
	            "date" : {
	                "type" : "date",
	                "format" : "dd MMM YYYY"
	            }
	        }
	    }
	}
}'

# see the explicit mapping set
curl localhost:9200/test/type1/_mapping?pretty=1

# show we can index the data with the above mapping
curl -XPUT localhost:9200/test/type1/1?pretty=1 -d '{
	"text" : "some textual content here",
	"count" : 10,
	"price" : 12.45,
	"date" : "27 May 2011"
}'
