For test pupose just run
docker-compose up --build

If you in development mode try to run server and Oracle db individually
docker run -d -p 1522:1521 --name oracle-xe gvenzl/oracle-xe

and for server 
npm run start