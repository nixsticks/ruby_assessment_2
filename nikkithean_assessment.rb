# Ruby Assessment

#1. Arrays

  array = ["Blake","Ashley","Jeff"]

# a. Add a element to an array

  array.push("Bob")

# b. Write a statement to print out all the elements of the array.

  array.each {|name| puts name}

# c. Return the value at index 1.

  array[1]

# d. Return the index for the value "Jeff".

  array.index("Jeff")

#2. Hashes

  instructor = {:name=>"Ashley", :age=>27}

# a. Add a new key for location and give it the value "NYC".

  instructor[:location] = "NYC"

# b. Write a statement to print out all the key/value pairs in the hash. This should *not be* just `puts my_hash` but should iterate over the structure printing each individual key and value.

  instructor.each {|key, value| puts "#{key}: #{value}"}

# c. Return the name value from the hash.

  instructor[:name]

# d. Return the key name for the value 27.

  instructor.key(27)

#3. Nested Structures

school = { 
  :name => "Happy Funtime School",
  :location => "NYC",
  :instructors => [ 
    {:name=>"Blake", :subject=>"being awesome" },
    {:name=>"Ashley", :subject=>"being better than blake"},
    {:name=>"Jeff", :subject=>"karaoke"}
  ],
  :students => [ 
    {:name => "Marissa", :grade => "B"},
    {:name=>"Billy", :grade => "F"},
    {:name => "Frank", :grade => "A"},
    {:name => "Sophie", :grade => "C"}
  ]
}

instructors = school[:instructors]
students = school[:students]

# NOTE!!! I know there are simpler ways to do this (i.e. just referring to the index) but I tried not to hard code anything

# a. Add a key to the school hash called "founded_in" and set it to the value 2013. 

  school[:founded_in] = 2013

# b. Add a student to the school's students' array.

  students << {:name => "Anisha", :grade => "A"}

# c. Remove "Billy" from the students' array. Create a solution that would work for any name given, then give it the name `"Billy"`.

  def remove_student(name, list)
    list.each {|student| list.delete(student) if student[:name] == name}
  end

  remove_student("Billy", students)

# d. Add a key to every student in the students array called "semester" and assign it the value "Summer".

  students.each {|student| student[:semester] = "Summer"}

# e. Change Ashley's subject to "being almost better than Blake". Create a solution that would work for any teacher given, then give it the teacher `"Ashley"`.

  def change_subject(list, name, new_subject)
    list.each {|teacher| teacher[:subject] = new_subject if teacher[:name] == name}
  end

  change_attribute(instructors, "Ashley", "subject", "being almost better than Blake")

# f. Change Frank's grade from "A" to "F". Create a solution that would work for any intial and replacement grade given, then give it the grades and `"A"` and `"F"`.
  # Note -- Why do I need to give it the initial grade? Can't I just give it Frank's name and the new grade? I'm confused. I wrote two methods; one to change any grades in the hash to any other grades, and one where you can change the grade of a specific student.

  def change_grades(list, old_grade, new_grade)
    list.each {|student| student[:grade] = new_grade if student[:grade] == old_grade}
  end

  def change_student_grade(list, name, new_grade)
    list.each {|student| student[:grade] = new_grade if student[:name] == name}
  end

  change_grades(students, "A", "F")
  change_student_grade(students, "Frank", "F")

# g. Return the name of the student with a "B". Create a solution that would work for any grade given, then give it the grade `"B"`.
  # NOTE!!! This returns an array, in case there is more than one student with a particular grade.
  
  def grade_lookup(list, grade)
    list.map {|person| person[:name] if person[:grade] == grade}.compact
  end

  grade_lookup(students, "B")

# h. Return the subject of the instructor "Jeff". Create a solution that would work for any instructor given, then give it the instructor `"Jeff"` and the new subject.
  # See above
  
  def subject_lookup(list, name)
    list.map {|person| person[:subject] if person[:name] == name}.compact
  end

  subject_lookup(instructors, "Jeff")

# i. Write a statement to print out all the values in the school. This should *not be* just `puts my_hash` but should iterate over the structure printing each individual key and value.
  # NOTE: Just wanted to format it nicely

  school.each do |key, value|
    puts "#{key}: "
    if value.respond_to?(:each)
      value.each do |collection|
        collection.each {|nested_key, nested_value| puts "\t#{nested_key}: #{nested_value}"}
      end
    else
      puts "\t#{value}"
    end
  end

#4. Methods

# Note: You will need to pass the school variable to each of these methods to include it in scope.

# a.  
# i. Create a method to return the grade of a student, given that student's name.

  def grade_lookup(list, name)
    list.map {|person| person[:grade] if person[:name] == name}.compact[0]
  end

# ii. Then use it to refactor your work in 3.i., i.e. use your method to replace some of the iteration that was initiailly required.
  #Still a teensy bit confused about what we were meant to do here... sorry:(

    school.each {|key, value| puts "#{key}: #{value}" unless value.respond_to?(:each)}
    puts "Instructors:"
    instructors.each do |instructor|
      instructor.each {|key, value| puts "#{key}: #{value}"}
    end
    students.each {|student| puts "#{student[:name]}: #{grade_lookup(students, student[:name])}"}
  
# b. 
# i.Create a method to update a instructor's subject given the instructor and the new subject.

  def update_subject(list, name, new_subject)
    list.each {|teacher| teacher[:subject] = new_subject if teacher[:name] == name}
  end

# ii. Then use it to update Blake's subject to "being terrible".

  update_subject(instructors, "Blake", "being terrible")

# c. 
# i. Create a method to add a new student to the schools student array.

  def add_student(list, name, grade, semester)
    list << {:name => name, :grade => grade, :semester => semester}
  end

# ii. Then use it to add yourself to the school students array.
  
  add_student(students, "Nikki", "A", "Fall-Spring")

# d. 
#  i. Create a method that adds a new key at the top level of the school hash, given a key and a value. 

  def add_key(list, key, value)
    list[key.to_sym] = value
  end

#  ii. Then use it to add a "Ranking" key with the value 1.

  add_key(school, :ranking, 1)

#5. Object Orientation

# a. Create a bare bones class definition for a School class.
  class School
  # c. Create an attr_accessor for name, location, instructors, and students. Create an attr_reader for ranking.
    attr_accessor :name, :location, :instructors, :students
    attr_reader :ranking

  # g. Create an array constant SCHOOLS that stores all instances of your School class.
    SCHOOLS = []

  # b. Define an initialize method for the School class.
  # i. Give your School class the instance variables: name, location, ranking, students, instructors.
  # NOTE: These variables should be of the same type as they are in the hash above.
  # ii. Rewrite your initialize method definition to take a parameter for each instance variable. 
  # iii. Initialize each instance variable with the value of the corresponding parameter.

    def initialize(name, location, ranking)
      @name = name
      @location = location
      @ranking = ranking
      @students = []
      @instructors = []
      SCHOOLS << self
    end

  # d. Create a method to set ranking, given a ranking value.

    def ranking(value)
      @ranking = value
    end

  # e. Create a method to add a student to the school, given a name, a grade, and a semester.

    def add_student(name, grade, semester)
      students << {:name => name, :grade => grade, :semester => semester}
    end

  # f. Create a method to remove a student from the school, given a name.

    def remove_student(name)
      students.each {|student| students.delete(student) if student[:name] == name}
    end

  # h. Create a class method `reset` that will empty the SCHOOLS constant.
    def self.reset
      SCHOOLS.clear
    end
  end


#6. Classes

# a. Create a Student class.

  class Student
    attr_accessor :name, :grade, :semester

    def initialize(name, grade, semester)
      @name = name
      @grade = grade
      @semester = semester
    end
  end

  # b. Refactor your School instance methods to treat Students as an array of objects instead of an array of hashes.

  class School
    attr_accessor :name, :location, :instructors, :students
    attr_reader :ranking

    SCHOOLS = []

    def initialize(name, location, ranking)
      @name = name
      @location = location
      @ranking = ranking
      @students = []
      @instructors = []
      SCHOOLS << self
    end

    def ranking(value)
      @ranking = value
    end

    #refactored
    def add_student(name, grade, semester)
      students << Student.new(name, grade, semester)
    end

    #refactored
    def remove_student(name)
      students.each {|student| students.delete(student) if student.name == name}
    end

    def reset
      SCHOOLS.clear
    end

  # c. Create a method in the School class that finds a student by name and returns the correct Student object. 
    def student_lookup(name)
      return_value = "Sorry, that student does not exist."
      students.map{|student| return_value = student if student.name == name }
      return_value
    end
  end

###7. Self

# a.What should this Class print to the screen when defined/loaded?

  class Student

    def self.say_hello
      puts "hello"
    end

    say_hello
    puts self

  end

# ANSWER: "hello", Student

# b. What should this Class print to the screen when defined/loaded?

  class Student

    def self.say_hello
      puts self
    end

    say_hello

  end

# ANSWER: Student

# c. What should this Class print to the screen when defined/loaded?

  class Student

    def initialize
      puts self
    end

    new

  end

# ANSWER: The object ID of a new Student object

# d. What should this code print to the screen when run?

  class Student

    def say_hello
      puts self
    end

  end

  Student.new.say_hello

# ANSWER: The object ID of a new Student object

# e. What should this code print to the screen when run?

  class Student

    def say_hello
      puts say_goodbye
    end

    def say_goodbye
      "goodbye"
    end

  end

  Student.new.say_hello

# ANSWER: "goodbye"