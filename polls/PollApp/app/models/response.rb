# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  respondent_id    :integer
#

class Response < ActiveRecord::Base
  validate :respondent_already_answered

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses.where.not(id: self.id)
    #  "returning..."
    # p result
    # result
  end



  def respondent_already_answered

     if self.sibling_responses.pluck(:respondent_id).include?(self.respondent_id)
      errors[:respondent] << "already answered"
    end
  end

end
