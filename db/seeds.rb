# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Equipment
References::Equipment.create(alias: 'barbell', name: 'Штанга')
References::Equipment.create(alias: 'dumbbell', name: 'Гантели')
References::Equipment.create(alias: 'weight', name: 'Утяжелитель')
References::Equipment.create(alias: 'cable', name: 'Трос')
References::Equipment.create(alias: 'lever_plate', name: 'Рычаги с блинами')
References::Equipment.create(alias: 'lever_selectorized', name: 'Рачаги с наборными блоками')
References::Equipment.create(alias: 'sled', name: 'Салазки')
References::Equipment.create(alias: 'smith', name: 'Рама Смита')