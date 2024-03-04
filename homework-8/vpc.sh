aws ec2 create-vpc     --cidr-block 10.0.0.0/16     --tag-specification 'ResourceType=vpc,Tags=[{Key=Optional,Value=MyVpc}]'
aws ec2 create-subnet \
    --vpc-id vpc-06a16a9e7dc79ff9c \
    --cidr-block 10.0.0.0/24 \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=my-ipv4-only-subnet}]'

aws ec2 create-internet-gateway \
    --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]'

aws ec2 create-subnet     --vpc-id vpc-06a16a9e7dc79ff9c     --cidr-block 10.0.1.0/24     --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=my-ipv4-private-subnet}]'
aws ec2 allocate-address --domain vpc 
aws ec2 create-nat-gateway \
    --subnet-id subnet-0641d52c955665815 \
    --allocation-id eipalloc-02dfff43f81d0ce08