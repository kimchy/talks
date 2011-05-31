# delete all data
curl -XDELETE localhost:9200/

# create *index1* with 2 shards and 1 replica
curl -XPUT localhost:9200/index1 -d '{
    "index" : {
        "number_of_shards" : 2,
        "number_of_replicas" : 1
    }
}'

# index some data into *index1*
curl -XPOST localhost:9200/index1/type1/1 -d '{
	"message" : "I am a message that exists on index1"
}'

# create *index2* with 1 shard and 2 replicas
curl -XPUT localhost:9200/index2 -d '{
    "index" : {
        "number_of_shards" : 1,
        "number_of_replicas" : 1
    }
}'

# index some data into *index2*
curl -XPOST localhost:9200/index2/type1/1 -d '{
	"message" : "I am a message that exists on index2"
}'

# search on *index1*
curl 'localhost:9200/index1/_search?q=message&pretty=1'

# search on *index2*
curl 'localhost:9200/index2/_search?q=message&pretty=1'

# search on *index1* and *index2*
curl 'localhost:9200/index1,index2/_search?q=message&pretty=1'

# search on "_all" indices
curl 'localhost:9200/_search?q=message&pretty=1'

