# mod-aws-ec2-opendistro

## Default usernames and Passwords 
Passwords for the reserved users should be changed, this includes the user kibanaserver and admin.    
The rest of the users can be changed from the console after setup.   

With this module You can either go with the default `admin:admin` and `kibanaserver:kibanaserver`, or use input variable to change during the deployment of the nodes. To use the input variable the password should be hashed, and the hashed value should be used as input.   
The tool to create hashed password is included with the opendistro tools:    
https://aws.amazon.com/blogs/opensource/change-passwords-open-distro-for-elasticsearch/   
```
/usr/share/elasticsearch/plugins/opendistro_security/tools/hash.sh
```

After deployment, and bootstrapping if a cluster is to be deployed, the security configuration needs to be applied.   
Logon to one of the nods and run the following command. If you are using your own certificates please update acordingly.

```
sudo bash /usr/share/elasticsearch/plugins/opendistro_security/tools/securityadmin.sh -cd /usr/share/elasticsearch/plugins/opendistro_security/securityconfig/ -icl -nhnv -cacert /etc/elasticsearch/root-ca.pem -cert /etc/elasticsearch/kirk.pem -key /etc/elasticsearch/kirk-key.pem
```


## Initial Bootstrapping an elastic cluster:

When using the module with input type `cluster` to create the first initial master nodes, they need to be bootstrapped.   
Logon to the first three nodes, add information about the two other initial master nodes to the hosts file (/etc/hosts/) or your shared dns service.   

Information needs to be added in the same manner as "node name" used in /etc/elasticsearch/elasticsearch.yml   
This module will use a combination of input name, sequence number and ip address to define its node and computer name.   
Important, if you are to use FQDN with let’s say a dns service, the node names need to reflect the hostname you reach the other nodes on.   

For Example: 
```    
172.28.0.130 28-0-elast01
172.28.1.132 28-1-elast02
172.28.2.53 28-2-elast03
```

Then the same info is required into /etc/elasticsearch/elasticsearch.yml   
```
echo -e 'cluster.initial_master_nodes: ["28-0-elast01", "28-1-elast02", "28-2-elast03"]' | sudo tee -a /etc/elasticsearch/elasticsearch.yml 
```

A reboot of the service triggers the cluster formation.   
```
sudo systemctl restart elasticsearch.service
```

Any other additional nodes to the cluster would not require any bootstrapping.   
If setting up the es node as type `single` no manual bootstrapping is required, and the node is supposed to live as single-host.   



## KeyStore - Kibana: 
To allow Kibana to communicate with elastic search a password and username is required.    
You have currently two options to store the password. You can either append this line to /etc/kibana/kibana.yml   

```
elasticsearch.password: th1s1smypa$$wordinClearText
```
this would obviously present security challenges and be unsecure and require additional security and permission on the files.   


A more preferred way is to use the KeyStore.   
KeyStore is bundled with Kibana and is located under bin/, on ubuntu that is /usr/share/kibana/bin .   

First Create a new KeyStore with value CREATE, then add keys and values with ADD.   
LIST and REMOVE is additional values accepted by KeyStore to either remove or list current keys.      

Create a new KeyStore, then add a key and inputs its value when requested.   
KeyStore needs to be run with the user who is to run the Kibana service, hence the sudo -su -s kibana.      
```
cd /usr/share/kibana/bin
sudo su -s /bin/bash kibana -c "./kibana-keystore create"
sudo su -s /bin/bash kibana -c "./kibana-keystore add elasticsearch.password"
```

This would prompt you to input the password to be used to authenticate against Elasticsearch.   
Note, the same Teqnique can be used with Logstash or Beats or any other modules in the stack.   

