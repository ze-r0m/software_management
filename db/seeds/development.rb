# Очищаем данные в правильном порядке (от зависимых к родителям)
RequestSoftAud.delete_all
ClassSoftware.delete_all
RequestSoft.delete_all
CompClass.delete_all
InstalledSoftware.delete_all
Cafedra.delete_all
Faculty.delete_all
User.delete_all

puts "Создание ролей и первого админа"
%w[admin moderator].each do |r|
  Role.find_or_create_by!(name: r)
end

admin_role = Role.find_by!(name: 'admin')
User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.username              = 'superadmin'
  u.password              = 'changeme123'
  u.password_confirmation = 'changeme123'
  u.role                  = admin_role
end

puts "Данные для admin\n"
puts "username: superadmin"
puts "email: admin@example.com"
puts "password: changeme123"


puts "Создание факультетов..."
faculties = [
  ['Авиа', 'Авиастроение'],
  ['АМиУ', 'Автоматизация, мехатроника и управление'],
  ['АП', 'Агропромышленный'],
  ['БЖиИЭ', 'Безопасность жизнедеятельности и инженерная экология'],
  ['БиоВедМед', 'Биоинженерия и ветеринарная медицина'],
  ['ДТ', 'Дорожно-транспортный'],
  ['ИБиМ', 'Иновационный бизнес и менеджмент'],
  ['ИиВТ', 'Информатика и Вычислительная Техника'],
  ['ИС', 'Инженерно-строительный'],
  ['ИФКиС', 'Институт Физической культуры и спорта'],
  ['М', 'Международный'],
  ['Маг', 'Отдел магистратуры'],
  ['МКиМТ', 'Медиакоммуникации и мультимедийные технологии'],
  ['МТиО', 'Машиностроительные технологии и оборудование'],
  ['ПГС', 'Промышленное и гражданское строительство'],
  ['ПиТР', 'Приборостроение и техническое регулирование'],
  ['ППД', 'Психология, педагогика и дефектология'],
  ['СГ', 'Социально-гуманитарный'],
  ['СТ', 'Сервис и туризм'],
  ['ТМ', 'Технология машиностроения'],
  ['ТСиЭ', 'Транспорт, сервис и эксплуатация'],
  ['УВОиПВО', 'Военный факультет'],
  ['ШАДИ', 'Школа архитектуры, дизайна и искусств'],
  ['ЭиНГП', 'Энергетика и нефтегазопромышленность'],
  ['Ю', 'Юридический']
]

faculties.each do |short, full|
  Faculty.find_or_create_by!(name: short, description: full)
end

puts "Создание кафедр..."
cafedras_data = [
  ['ТФиХОМ', 'Технологии формообразования и художественная обработка материалов', 'МТиО'],
  ['АПП', 'Автоматизация производственных процессов', 'АМиУ'],
  ['ИиКГ', 'Инженерная и компьютерная графика', 'АП'],
  ['ГГиТП', 'Гидравлика, гидропневмоавтоматика и тепловые процессы', 'АМиУ'],
  ['ЕН', 'Естественные науки', 'М'],
  ['МиИЭ', 'Маркетинг и инженерная экономика', 'ИБиМ'],
  ['НТПиПК', 'Научно-технический перевод и профессиональная коммуникация', 'СГ'],
  ['ИТ', 'Информационные технологии', 'ИиВТ'],
  ['ИиК', 'История и культурология', 'МКиМТ'],
  ['МиАСП', 'Машины и автоматизация сварочного производства', 'МТиО'],
  ['КиПП', 'Коммерческое и предпринимательское право', 'Ю'],
  ['ОП', 'Основы правоведения', 'Ю'],
  ['ТТПП', 'Техника и технологии пищевых производств', 'АП'],
  ['МРСиИ', 'Металлорежущие станки и инструменты', 'ТМ'],
  ['ОКМ', 'Основы конструирования машин', 'ТМ'],
  ['ЭМ', 'Экономика и менеджмент', 'ИБиМ'],
  ['БЖиЗОС', 'Безопасность жизнедеятельности и защита окружающей среды', 'БЖиИЭ'],
  ['ПОВТиАС', 'Программное обеспечение вычислительной техники и автоматизированных систем', 'ИиВТ'],
  ['ПИ', 'Педагогические измерения', 'ППД'],
  ['ФВ', 'Физвоспитание', 'ИФКиС']
]

cafedras_data.each do |abbr, full_name, faculty_code|
  faculty = Faculty.find_by(name: faculty_code)

  if faculty
    Cafedra.find_or_create_by!(
      name: abbr,
      description: full_name,
      faculty_id: faculty.id
    )
  else
    puts "⚠️ Факультет '#{faculty_code}' не найден для кафедры '#{abbr}'"
  end
end

puts "Создание компьютерных классов..."
auditoriums = [
  ['1-101', 30, 25, true, false, true, 'Многофункциональный класс', Cafedra.find_by(name: 'ТФиХОМ')],
  ['1-102', 25, 20, false, true, true, 'Класс для презентаций', Cafedra.find_by(name: 'АПП')],
  ['2-201', 35, 30, true, false, false, 'Лаборатория для программирования', Cafedra.find_by(name: 'БЖиЗОС')],
  ['2-202', 20, 15, false, true, true, 'Класс для обучения CAD', Cafedra.find_by(name: 'ГГиТП')],
  ['3-301', 40, 35, true, true, true, 'Большой класс для потоков', Cafedra.find_by(name: 'ЕН')],
  ['3-302', 28, 24, true, true, true, 'Для работы с VR', Cafedra.find_by(name: 'ИТ')],
  ['4-401', 32, 28, true, false, true, 'Класс для математики', Cafedra.find_by(name: 'ИиК')],
  ['4-402', 24, 20, false, true, true, 'Лаборатория для химии', Cafedra.find_by(name: 'ИиКГ')],
  ['5-501', 30, 28, true, false, true, 'Мультимедийный класс', Cafedra.find_by(name: 'КиПП')],
  ['5-502', 20, 18, true, false, true, 'Класс для IT-проектов', Cafedra.find_by(name: 'МиАСП')],
  ['6-601', 40, 30, true, true, true, 'Аудитория для изучения маркетинга', Cafedra.find_by(name: 'МиИЭ')],
  ['6-602', 30, 25, false, true, false, 'Класс для преподавателей экономики', Cafedra.find_by(name: 'МРСиИ')],
  ['7-701', 25, 22, true, true, false, 'Класс для менеджеров', Cafedra.find_by(name: 'НТПиПК')],
  ['7-702', 22, 18, true, true, true, 'Семинар по менеджменту', Cafedra.find_by(name: 'ОКМ')],
  ['8-801', 35, 30, true, false, true, 'Инженерный класс', Cafedra.find_by(name: 'ОП')],
  ['8-802', 28, 22, false, true, true, 'Лаборатория для прототипирования', Cafedra.find_by(name: 'ПИ')],
  ['9-901', 30, 28, true, false, false, 'Лаборатория искусственного интеллекта', Cafedra.find_by(name: 'ПОВТиАС')],
  ['9-902', 25, 20, true, true, true, 'Класс для работы с Python', Cafedra.find_by(name: 'ТТПП')],
  ['10-101', 35, 30, true, true, true, 'Лаборатория для инженерии', Cafedra.find_by(name: 'ТФиХОМ')],
  ['10-102', 30, 25, false, true, true, 'Пространство для студентов по ОКП', Cafedra.find_by(name: 'ФВ')],
  ['11-101', 30, 28, true, true, true, 'Класс для хардварных проектов', Cafedra.find_by(name: 'ЭМ')],
  ['11-102', 28, 24, true, false, false, 'Класс для робототехники', Cafedra.find_by(name: 'АПП')],
  ['12-201', 32, 28, false, true, true, 'Лаборатория для биоинженерии', Cafedra.find_by(name: 'БЖиЗОС')],
  ['12-202', 22, 18, true, false, true, 'Пространство для стартапов', Cafedra.find_by(name: 'ИТ')],
  ['13-301', 40, 35, true, true, false, 'Класс для инженерной графики', Cafedra.find_by(name: 'ИиКГ')],
  ['13-302', 24, 20, false, true, true, 'Класс для изучения права', Cafedra.find_by(name: 'ЭМ')],
  ['14-401', 30, 25, true, false, true, 'Класс для спортивных мероприятий', Cafedra.find_by(name: 'ФВ')],
  ['14-402', 20, 15, true, true, true, 'Лаборатория для туризма', Cafedra.find_by(name: 'БЖиЗОС')],
  ['15-501', 35, 30, true, false, true, 'Пространство для авиастроения', Cafedra.find_by(name: 'ГГиТП')],
  ['15-502', 25, 20, false, true, true, 'Класс для машиностроительных технологий', Cafedra.find_by(name: 'АПП')],
]

auditoriums.each do |aud_number, seats, comp_seats, projector, panel, board, purpose, cafedra|
  CompClass.create!(
    aud_number: aud_number,
    cafedra: cafedra,
    count_seat: seats,
    count_comp_seat: comp_seats,
    count_comp: comp_seats,
    projector: projector,
    panel: panel,
    ch_board: board,
    spec_purpose: purpose
  )
end


puts "Создание установленного ПО..."
software_list = [
  ['Microsoft Office', '2021', Date.new(2023, 1, 1), Date.new(2025, 12, 31), 'Иванов И.И.', false, 'офис', 554, 'Tr34543564363 от 14.06.2024. Контрагент Донской государственный технический университет', ['обеспечивающее', 'учебное']],
  ['Adobe Photoshop', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Дизайн-отдел', false, 'дизайн', 435, 'Сублицензионный договор от 13 апреля№ЛС-9999-9999', ['обеспечивающее']],
  ['Visual Studio', '2022', Date.new(2024, 1, 1), Date.new(2026, 12, 31), 'Петров П.П.', false, 'dev', 150, 'Договор от 01.03.2024 №333/пьрТ', ['учебное']],
  ['AutoCAD', '2024', Date.new(2024, 3, 1), Date.new(2025, 12, 31), 'Архитектура', false, 'cad', 1000, 'Договор от 01.03.2454 №143/ИТ', ['учебное', 'обеспечивающее']],
  ['Blender', '3.6', Date.new(2023, 5, 1), Date.new(2025, 5, 1), '3D-отдел', false, '3d', 456, 'Договор от 03.03.2444 №673/рьпрбо', ['учебное']],
  ['MATLAB', 'R2023b', Date.new(2023, 9, 1), Date.new(2026, 8, 31), 'Лаб. моделирования', false, 'наука', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['LibreOffice', '7.6', Date.new(2024, 2, 1), Date.new(2025, 12, 31), 'Бухгалтерия', false, 'офис', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['MySQL', '8.0', Date.new(2023, 2, 1), Date.new(2026, 1, 31), 'Сисадмин', true, 'сервер', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['PostgreSQL', '15.0', Date.new(2024, 1, 1), Date.new(2027, 12, 31), 'DevOps', true, 'сервер', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Microsoft Access', '2021', Date.new(2023, 1, 1), Date.new(2025, 12, 31), 'База данных', false, 'db', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Microsoft Project', '2021', Date.new(2023, 1, 1), Date.new(2025, 12, 31), 'Планировщик', false, 'план', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Microsoft Visio', '2021', Date.new(2023, 1, 1), Date.new(2025, 12, 31), 'Аналитик', false, 'схемы', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Microsoft SQL Server', '2022', Date.new(2024, 1, 1), Date.new(2026, 12, 31), 'DBA', true, 'сервер', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe Premiere Pro', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Видео-отдел', false, 'видео', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe After Effects', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Анимация', false, 'видео', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe InDesign', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Верстка', false, 'публика', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe Dreamweaver', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Веб-отдел', false, 'html', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe Audition', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Звукорежиссёр', false, 'аудио', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe Bridge', 'CC 2023', Date.new(2023, 6, 1), Date.new(2024, 5, 31), 'Медиа-менеджер', false, 'медиа', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Adobe Illustrator', 'CC 2022', Date.new(2022, 1, 1), Date.new(2023, 12, 31), 'Графика', false, 'архив', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['CorelDRAW', '2022', Date.new(2021, 6, 1), Date.new(2023, 6, 1), 'Печать', false, 'архив', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['SketchUp', '2021', Date.new(2020, 5, 1), Date.new(2023, 5, 1), '3D-модели', false, 'архив', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['3ds Max', '2021', Date.new(2021, 1, 1), Date.new(2023, 1, 1), '3D-анимация', false, 'архив', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']],
  ['Cinema 4D', 'R23', Date.new(2021, 3, 1), Date.new(2023, 3, 1), 'Видео студия', false, 'архив', 100, 'Договор от 01.03.2024 №123/ИТ', ['учебное', 'обеспечивающее']]
]

softwares = software_list.map do |name, version, start_date, end_date, keyholder, is_server, note, quantity, usage_basis, purpose|
  InstalledSoftware.create!(
    name: name,
    version: version,
    start_date: start_date,
    finish_date: end_date,
    keyholder: keyholder,
    is_server: is_server,
    note: note,
    quantity: quantity,
    usage_basis: usage_basis,
    purpose: purpose
  )
end

puts "Связываем ПО с аудиториями..."
# Привязка ПО к аудиториям
classrooms = CompClass.all
# ClassSoftware.create!(comp_class: classrooms[0], installed_software: softwares[0]) # Office
# ClassSoftware.create!(comp_class: classrooms[1], installed_software: softwares[1]) # Photoshop
# ClassSoftware.create!(comp_class: classrooms[2], installed_software: softwares[5]) # Blender
# ClassSoftware.create!(comp_class: classrooms[3], installed_software: softwares[3]) # AutoCAD
# ClassSoftware.create!(comp_class: classrooms[4], installed_software: softwares[4]) # MATLAB
# ClassSoftware.create!(comp_class: classrooms[5], installed_software: softwares[6]) # LibreOffice

class_softwares = {
  0 => [0, 1, 4],
  1 => [2, 3, 5],
  2 => [6, 7],
  3 => [8, 9, 6],
  4 => [10, 11],
  5 => [0, 12],
  6 => [5, 3],
  7 => [6, 1, 13],
  8 => [8, 9, 0],
  9 => [2, 10],
  10 => [11, 13],
  11 => [0, 12],
  12 => [6, 8],
  13 => [9, 10],
  14 => [5, 3],
  15 => [2, 13],
  16 => [1, 0],
  17 => [12, 6],
  18 => [11, 9],
  19 => [10, 5],
  20 => [2, 6],
  21 => [3, 13],
  22 => [1, 8],
  23 => [9, 0],
  24 => [12, 11],
  25 => [10, 2],
  26 => [13, 5],
  27 => [6, 8],
  28 => [0, 1, 12]
}

class_softwares.each do |class_idx, software_indices|
  software_indices.each do |soft_idx|
    ClassSoftware.create!(
      comp_class: classrooms[class_idx],
      installed_software: softwares[soft_idx]
    )
  end
end

# puts "Создание заявок на ПО..."
# request1 = RequestSoft.create!(
#   soft_name: 'Visual Studio Code',
#   version: '1.85',
#   count: 15,
#   price: 0.00,
#   contact: 'Иванов Иван, тел. 8-900-123-45-67',
#   cafedra: Cafedra.find_by(name: 'ИТ')
# )
#
# request2 = RequestSoft.create!(
#   soft_name: 'AutoCAD',
#   version: '2024',
#   count: 10,
#   price: 150000.00,
#   contact: 'Петрова Мария, тел. 8-901-234-56-78',
#   cafedra: Cafedra.find_by(name: 'АПП')
# )
#
# RequestSoftAud.create!(request_soft: request1, comp_class: classrooms[0])
# RequestSoftAud.create!(request_soft: request2, comp_class: classrooms[5])

puts "✅ Данные успешно загружены!"
