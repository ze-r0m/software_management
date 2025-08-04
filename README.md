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

* Доступ к системе  
  При выполнении сидера создается супер админ, с помощью этих учетных данных выполняется доступ к системе
        username: superadmin  
        email: admin@example.com  
        password: changeme123  


* Вход в контейнер
        docker exec -it software_management-web-1 bash
* Билд продакшена 
  *     docker compose -f docker-compose.prod.yml build


docker compose -f docker-compose.prod.yml -p software_management_prod up -d

docker compose -f docker-compose.prod.yml -p software_management_prod --env-file .env.production -p software_prod up --build
docker compose -f docker-compose.prod.yml --env-file .env.production -p software_prod exec web rails db:migrate


docker compose -f docker-compose.prod.yml -p software_management_prod --env-file .env.production -p software_prod up -d --build

docker compose -f docker-compose.prod.yml --env-file .env.production -p software_prod up -d --build
docker compose -f docker-compose.prod.yml --env-file .env.production -p software_prod exec web rails db:migrate

docker compose -f docker-compose.prod.yml -p software_management_prod --env-file .env.production -p software_prod exec web rails db:migrate
docker compose -f docker-compose.prod.yml -p software_management_prod --env-file .env.production -p software_prod exec web rails db:seed

подключение к бд
docker compose -f docker-compose.prod.yml --env-file .env.production -p software_prod exec db mysql -u root -p


### Выявленые баги и задачи к выполнению




- [ ] !Docker.prod
- [X] Упростить проверку на роль, перенести в метод юзера
- [X] bug  не вносится держатель ключа в ПО

- [X] seed prod
- [ ] Алерт переход при отсутствии записи в контролере (факультеты, кафедры, аудитории)
- [X] Soft delete
    - [X] Факультеты
    - [X] Кафедры
    - [X] Аудитории
    - [X] ПО
- [ ] Сортировки во всех таблицах!!!!!!
- 
- [X] Кнопки очистки фильтров должны работать без перезагрузки страницы 
    - [X] факультеты
    - [X] кафедры
    - [X] аудитории
    - [X] ПО
    - [X] Пользователи
- [X] Таблица ПО: В фильтрах с чекбоксами и сроками - нажатие на текст, а не только на бокс
- [Х] Таблица ПО: добавить фильтр(рычаг) для отображения только серверного ПО
- [X] Форма ПО: выпадающий список добавления аудиторий привести в вид, отобразить снизу вверх
- [X] Таблица Ауд: Выпадающие списки - при нажатии на чекбокс не пропадает, а на текст то пропадает список(исчезновение выпадающего списка после увода курсора)
- [X] Уведомление при создании пользователя не переведено на русский
- [X] ВАЛИДАЦИЯ ПОЛЕЙ ВО ВСЕМ ПРОЕКТЕ!!!!!! :  
    - [X] Факультеты
      - [X] Поля фильтрации
      - [X] Поля формы добаления  
      
    - [X] Кафедры
        - [X] Поля фильтрации
        - [X] Поля формы добаления  
      
    - [X] Аудитории
      - [X] Поля фильтрации
      - [X] Поля формы добаления
      
    - [X] ПО
      - [X] Поля фильтрации
      - [X] +-Поля формы добаления  
      
    - [X] Пользователи
        - [X] Поля фильтрации
        - [X] Поля формы добаления


- [ ] ...Кнопка скрытия и показа фильтров в шапке таблицы
- [X] !При переходе из Аудиторий в ПО(по выбранным аудиториям) - не показывать в поле фильтрации выбранные аудитории. Там вообще по кнопке не правильная ссылка формируется
- [ ] Вопрос - второй заголовок(фильтры) и прокрутка таблицы в ширину div class="table-responsive"
- [ ] Фильтрация связанных данных через политики доступа

- [X] добавить лого управления на страницу
- [ ] Создание логики и проектирование раздела "Заявки"
- [X] Тост уведомления
  

* ТАБЛ ПО:  
  - [X] Фильтр если ПО бессрочное
  - [X] В ПО без срока показывать дату когда начато(закуплено) и о том что оно бессрочно
  - [X] Добавить поле указывающее сколько было закуплено ПО
  - [X] Фильтр для кол-ва закупленного ПО
  - [X] Два поля "Основание использования" - большой текст, "Назначение" - два значения "обеспечивающее", "учебное" их отображать только при детальном просмотре
  - [ ] 