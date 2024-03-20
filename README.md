# SCBTodoListTest
This project make for SCB Technical Test

# Required
- Flutter **3.16.9**
- Please use develop branch to test

# Optional
- Required FVM to config flutter version
- You can run this shell script via '**$root/initial.sh**'.

# Detail
We have 2 environment for develop in this project. You can change environment in assets.env to '**mock**' or '**prod**' for build project
- **MOCK** : get mock data from json file via mock datasource
- **PROD** : get real data from service via remote datasource

# Testing
We using mockito to write unit test in bloc cubit
