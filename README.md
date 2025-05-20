# README
# Система управления лицензиями программного обеспечения

* Ruby version

  ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [x64-mingw-ucrt]
  Rails 8.0.2



* БД  
В качестве бд для системы используется MySQL 8  
Схема на этапе проектирования системы:
![схема данных учет ПО.png](%D1%81%D1%85%D0%B5%D0%BC%D0%B0%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D1%83%D1%87%D0%B5%D1%82%20%D0%9F%D0%9E.png)
Эту схему считать приоритетной:
![схема бд.png](%D1%81%D1%85%D0%B5%D0%BC%D0%B0%20%D0%B1%D0%B4.png)
В системе уже имеется сидер с набором "мок" данных, 
созданием суперадмина, нескольким записями о факультетах, кафедрах, компьютерных классах, и программного обеспечения.  
Для применения сидера выполнить следующую команду:

      rails db:migrate:seed

<details>
<summary>С гемом mysql2 была выявлена проблема</summary>

### С гемом mysql2 была выявлена проблема
https://github.com/brianmario/mysql2/issues/1391  
При добавлении гема он собирает его для не существующей версии mysql, даже с точным указанием расположения mysql server

#### Схема восстановления гема mysql2

    gem uninstall mysql2
    git clone https://github.com/brianmario/mysql2.git
    cd mysql2
    git checkout 0.5.6
    notepad ext\mysql2\client.c
        Закомментировать строки 1541–1543 в файле client.c
    notepad .\lib\mysql2\version.rb
        изменить версию на 0.5.6.1

    module Mysql2
    VERSION = "0.5.6.1".freeze
    end

    gem build mysql2.gemspec

Сбилженная версия и клон репозитория гема уже находятся в корне проекта

    copy .\mysql2-0.5.6.1.gem ..\..\RubymineProjects\software_management\
    cd ..\..\RubymineProjects\software_management\
    Remove-Item Gemfile.lock
    изменить gemfile:
        gem "mysql2", "~> 0.5.6.1", path: "./"

установить кастом гема

    gem install .\mysql2-0.5.6.1.gem
    gem install .\mysql2-0.5.6.1.gem -- --with-mysql-dir="C:/MySQL/MySQL Server 8.0"  
    bundle install

</details>

* Доступ к системе  
  При выполнении сидера создается супер админ, с помощью этих учетных данных выполняется доступ к системе
        username: superadmin  
        email: admin@example.com  
        password: changeme123  
