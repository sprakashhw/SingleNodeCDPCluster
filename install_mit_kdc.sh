PUBLIC_HOSTNAME=`curl http://169.254.169.254/latest/meta-data/public-hostname`
yum install -y krb5-server krb5-libs krb5-workstation
mv conf/krb5.conf /etc/krb5.conf
sed -i "s/Yourhostname/$PUBLIC_HOSTNAME/g" /etc/krb5.conf
kdb5_util create -s -P Databricks@2021
systemctl start krb5kdc
systemctl enable krb5kdc
systemctl enable kadmin
systemctl restart kadmin
kadmin.local  -q "addprinc -pw Databricks@2021  admin/admin@EXAMPLE.COM"
