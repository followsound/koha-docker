koha-docker
======

[![Join the chat at https://gitter.im/open-source-knihovna/koha-docker](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/open-source-knihovna/koha-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Docker balíček s českou instalací Kohy

Pro spuštění je nutné mít nainstalované dvě komponenty:
- http://docs.docker.com/installation/debian/
- http://docs.docker.com/compose/install/

Koha  se skládá z více docker kontejnerů:
- mysql
- adminer
- samotná Koha

Tyto kontejnery je nutné za pomocí nástroje docker-compose spojit.

vytvoříme soubor `docker-compose.yml`
```
mysql:
  image: mysql
  environment:
   - MYSQL_USER=koha_knihovna
   - MYSQL_PASSWORD=tajneHeslo
   - MYSQL_ROOT_PASSWORD=tajneHeslo
   - MYSQL_DATABASE=koha_knihovna
adminer:
  image: clue/adminer
  links:
   - mysql:mysql
  ports:
   - "81:80"
koha:
  image: opensourceknihovna/koha-docker
  links:
    - mysql:mysql
  environment:
    - KOHA_PASSWORD=tajneHeslo
  ports:
    - "80:80"
    - "8080:8080"
```

poté příkazem `docker-compose up -d`  pustíme.

Po chvíli se Koha spustí na standardním portu 80 a její administrátorské rozhraní na portu 8080. Na portu 81 běží adminer (pozor do admineru do host je nutné zadat mysql, nikoliv localhost).
