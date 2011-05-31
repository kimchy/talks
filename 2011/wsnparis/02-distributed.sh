# start with one server

# delete all data
curl -XDELETE localhost:9200/

# create an index with two shards and 1 replica
curl -XPUT localhost:9200/index1 -d '{
    "index" : {
        "number_of_shards" : 2,
        "number_of_replicas" : 1
    }
}'

# one server, 2 shard instances are allocated
curl -XGET localhost:9200/_cluster/state?pretty=1

# index some data if you want...
curl -XPOST localhost:9200/index1/talk?pretty=1 -d '{
	"speaker" : "Adrian Colyer",
	"title" : "Enterprise Applications in 2011 Challenges in Development and Deployment, and Springs response"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Boris Bokowski",
	"title" : "Introducing Orion: Embracing the Web for Software Development Tooling"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Howard Lewis Ship",
	"title" : "Towards the Essence of Programming"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Jevgeni Kabanov",
	"title" : "Do you really get memory?"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Jags Ramnarayan",
	"title" : "SQLFabric - Scalable SQL instead of NoSQL"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Brad Drysdale",
	"title" : "HTML5 WebSockets : the Web Communication revolution, making the impossible possible"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Neal Gafter",
	"title" : ""
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Rob Harrop",
	"title" : "Multi-Platform Messaging with RabbitMQ"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Theo Schlossnagle",
	"title" : "Service Decoupling in Carrier-Class Architectures"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Michaël Chaize",
	"title" : "Architecting user-experiences"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Jonas Bonér",
	"title" : "Akka: Simpler Scalability, Fault-Tolerance, Concurrency & Remoting through Actors"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Shay Banon",
	"title" : "ElasticSearch - A Distributed Search Engine"
}'

curl -XPOST localhost:9200/index1/talk -d '{
	"speaker" : "Kohsuke Kawaguchi",
	"title" : "Taking Continuous Integration to the next level with Jenkins"
}'

# start another server, and see the rest of the shards allocated
curl -XGET localhost:9200/_cluster/state?pretty=1

# start another server, and see shards rebalance
curl -XGET localhost:9200/_cluster/state?pretty=1

#kill the first node and see a new master being elected, and new primary shards
curl -XGET localhost:9201/_cluster/state?pretty=1

#start the first node back up, and see again shards rebalance
curl -XGET localhost:9200/_cluster/state?pretty=1

#increase the number of replicas
curl -XPUT localhost:9200/index1/_settings -d '{
	"index" : {
	    "number_of_replicas" : 2
	}
}'
curl -XGET localhost:9200/_cluster/state?pretty=1
