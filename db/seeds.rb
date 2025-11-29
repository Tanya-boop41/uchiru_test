puts "Создаём школу..."

school = School.find_or_create_by!(
  id: 1,
  name: "Школа №1"
)

puts "Создаём классы..."

class_a = Classroom.find_or_create_by!(
  id: 1,
  school: school,
  number: 1,
  letter: "А"
)

class_b = Classroom.find_or_create_by!(
  id: 2,
  school: school,
  number: 1,
  letter: "Б"
)

puts "Создаём студентов..."

Student.find_or_create_by!(
  id: 1,
  first_name: "Вячеслав",
  last_name: "Абдурахмангаджиевич",
  surname: "Мухобойников-Сыркин",
  school: school,
  classroom: class_a
)

Student.find_or_create_by!(
  id: 2,
  first_name: "Мария",
  last_name: "Эдуардовна",
  surname: "Тужа",
  school: school,
  classroom: class_b
)

puts "Done!"
