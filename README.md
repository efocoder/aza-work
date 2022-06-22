# README
Transaction microservice

### Build app
```bash
 docker-compose build
 ```
### Run migrations and seed
```bash
  docker-compose exec web sh
  
  rake db:migrate
  
  rake db:seed
```

### Start the application
```bash
  docker-compose up 
```