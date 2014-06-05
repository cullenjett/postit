###################
# Using 'Concern' #
###################

module Voteable
  extend ActiveSupport::Concern


  included do
    has_many :votes, as: :voteable
  end


  def total_votes
      self.up_votes - self.down_votes
    end


  def up_votes
    self.votes.where(vote: true).size
  end


  def down_votes
    self.votes.where(vote: false).size
  end

end #Voteable



############################
# Classic Meta-Programming #
############################

=begin
module Voteable

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)

    base.class_eval do
      add_vote_relationship
    end
  end


  module InstanceMethods
    def total_votes
      self.up_votes - self.down_votes
    end


    def up_votes
      self.votes.where(vote: true).size
    end


    def down_votes
      self.votes.where(vote: false).size
    end
  end # InstanceMethods


  module ClassMethods
    def add_vote_relationship
      has_many :votes, as: :voteable
    end
  end #ClassMethods
end #Voteable
=end