puts "Создаём школу..."

school = School.find_or_create_by!(
  name: "Школа №1"
)

puts "Создаём классы..."

class_a = Classroom.find_or_create_by!(
  school: school,
  number: 1,
  letter: "А"
)

class_b = Classroom.find_or_create_by!(
  school: school,
  number: 1,
  letter: "Б"
)

puts "Создаём студентов..."

Student.find_or_create_by!(
  first_name: "Вячеслав",
  last_name: "Абдурахмангаджиевич",
  surname: "Мухобойников-Сыркин",
  school: school,
  classroom: class_a
)

Student.find_or_create_by!(
  first_name: "Мария",
  last_name: "Эдуардовна",
  surname: "Тужа",
  school: school,
  classroom: class_b
)

ActiveRecord::Base.connection.reset_pk_sequence!('students')

puts "Done!"
