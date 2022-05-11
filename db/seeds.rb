# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create([
  {
    email: 'admin@gmail.com',
    password: 'password',
    role: 'admin'
  },
  {
    email: 'user1@gmail.com',
    password: 'password',
    role: 'user'
  },
  {
    email: 'user2@gmail.com',
    password: 'password',
    role: 'user'
  }
]
           )
Category.create([
  {
    name: 'Sports'
  },
  {
    name: 'News'
  },
  {
    name: 'Technology'
  },
  {
    name: 'History'
  }
]
               )
que1 = Question.new(title: 'Who is the prime minister of nepal')
que1.options.new([
  {
    title: 'Sher Bahadur Deuwa',
    correct: true
  },
  {
    title: 'Puspa Kamal Dahal'
  },
  {
    title: 'Kp oli'
  }
]
                )
que1.categories = [Category.first, Category.second]
que1.save!
que2 = Question.new(title: 'Which country won FIFA worldcup 2018')
que2.options.new([
  {
    title: 'Brazil'
  },
  {
    title: 'France',
    correct: true

  },
  {
    title: 'Germany'
  },
  {
    title: 'Nepal'
  }
]
                )
que2.categories = [Category.last, Category.second]
que2.save!
que3 = Question.new(title: 'Who is the father of C programming language')
que3.options.new([
  {
    title: 'Richard Trevithick'
  },
  {
    title: 'Yukihiro Matsumoto'

  },
  {
    title: 'Lady Augusta'
  },
  {
    title: 'Dennis Ritchie',
    correct: true

  }
]
                )
que3.categories = [Category.last, Category.second]
que3.save!
