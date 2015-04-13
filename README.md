koha-docker
======

[![Join the chat at https://gitter.im/open-source-knihovna/koha-docker](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/open-source-knihovna/koha-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Docker balíček s českou instalací Kohy https://github.com/ceskaexpedice/kramerius

Pro spuštění je nutné mít nainstalované dvě komponenty:
- http://docs.docker.com/installation/debian/
- http://docs.docker.com/compose/install/

Protože se Koha skládá z více docker kontejnerů, tak je nutné je za pomocí nástroje docker-compose spojit.

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
  build: .
  links:
    - mysql:mysql
  ports:
    - "80:80"
    - "8080:8080"
```
