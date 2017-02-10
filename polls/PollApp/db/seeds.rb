# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# users = User.create!([{ user_name: 'Bob' }, { user_name: 'Joe' }, { user_name: 'Jane' }])
#
# favorite_colors = Question.create!(text: "What is your favorite color?" , poll_id: 1)
# favorite_teams = Question.create!(text: "What is your favorite team?", poll_id: 1)
# leader = Question.create!(text: "Vote for your leader", poll_id: 2)


# blue = AnswerChoice.create!(answer_text: "Blue", question_id: 1)
# red = AnswerChoice.create!(answer_text: "Red", question_id: 1)
# green = AnswerChoice.create!(answer_text: "Green", question_id: 1)
# lions = AnswerChoice.create!(answer_text: "Lions", question_id: 2)
# steelers = AnswerChoice.create!(answer_text: "Steelers", question_id: 2)
# trump = AnswerChoice.create!(answer_text: "Trump", question_id: 3)
# clinton = AnswerChoice.create!(answer_text: "Clinton", question_id: 3)

#
# a = Poll.create!(title: "favorites", author_id: 1)
# b = Poll.create!(title: "election", author_id: 3)
#
# joe_res1 = Response.create!(answer_choice_id: 1, respondent_id: 2)
# joe_res2 = Response.create!(answer_choice_id: 4, respondent_id: 2)

jane_res1 = Response.create!(answer_choice_id: 3, respondent_id:3)
jane_res1 = Response.create!(answer_choice_id: 4, respondent_id:2)
